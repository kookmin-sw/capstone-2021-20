package board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.dto.BoardDto;

public class BoardDao {
	
	Connection conn = null; // DB접속
	PreparedStatement pstmt = null; // SQL실행
	ResultSet rs = null; // select의 결과 처리
	
	public static final String url = "jdbc:mysql://localhost/boarddb?useUnicode=yes&characterEncoding=UTF-8&useServerPrepStmts=true";
	public static final String id = "root";
	public static final String pw = "ghdwlsdnr426!";
	
	  
	public BoardDao() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated constructor stub
	}

	public List<BoardDto> getBoardList(int startRow, int endRow, String keyword) throws ClassNotFoundException, SQLException {
	
		System.out.println(keyword);
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		List<BoardDto> list = new ArrayList<BoardDto>();
		System.out.println(startRow);
		System.out.println(endRow);
		try {
			String sql = "select b.* from "
					+ "(select a.*, @rownum:=@rownum+1 as no "
					+ "from (select seq, title, writer, content, reg_dtm "
					+ "from boarddb.board b where title like ? order by seq desc) a  "
					+ "WHERE (@rownum:=0)=0) b where no between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("data");
				BoardDto boardDto = new BoardDto();
				boardDto.setSeq(rs.getInt("seq"));
				boardDto.setTitle(rs.getString("title"));
				boardDto.setWriter(rs.getString("writer"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setReg_dtm(rs.getString("reg_dtm"));
				list.add(boardDto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return list;
	}
	
	public List<BoardDto> getBoardRankList() throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		List<BoardDto> list = new ArrayList<BoardDto>();
		try {
			String sql = "select writer, count(*) as count"
					+ "   from board"
					+ "  group by writer"
					+ "  order by count(*) desc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto boardDto = new BoardDto();
				boardDto.setWriter(rs.getString("writer"));
				boardDto.setCount(rs.getInt("count"));
				list.add(boardDto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return list;
	}
	
	public List<BoardDto> getBoardLikedList() throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		List<BoardDto> list = new ArrayList<BoardDto>();
		try {
			String sql = "select *"
					+ "   from board"
					+ "  order by liked desc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto boardDto = new BoardDto();
				boardDto.setSeq(rs.getInt("seq"));
				boardDto.setTitle(rs.getString("title"));
				boardDto.setLiked(rs.getInt("liked"));
				list.add(boardDto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return list;
	}
	
	public BoardDto getBoard(int seq) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		BoardDto boardDto = new BoardDto();
		try {
			String sql = "select * from board where seq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				boardDto.setSeq(rs.getInt("seq"));
				boardDto.setTitle(rs.getString("title"));
				boardDto.setWriter(rs.getString("writer"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setReg_dtm(rs.getString("reg_dtm"));
				boardDto.setLiked(rs.getInt("liked"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return boardDto;
	}
	
	public int updateBoard(BoardDto board) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		int result = 0;
		try {
			String sql = "update board set title = ?, content = ? where seq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getSeq());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return result;
	}
	
	public int updateBoardLiked(BoardDto board) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		int result = 0;
		try {
			String sql = "update board set liked = liked + 1 where seq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getSeq());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return result;
	}
	
	public int insertBoard(BoardDto board) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		int result = 0;
		try {
			String sql = "insert into board (writer, title, content) values (?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return result;
	}
	
	
	
	public int deleteBoard(int seq) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		int result = 0;
		try {
			String sql = "delete from board where seq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		
		return result;
	}
	


	
	public int getBoardCount(String keyword) throws ClassNotFoundException, SQLException{
		
		int count = 0;
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pw);
		System.out.println("연결 성공");
		
		try {
			
			String sql = "select count(*) from board where title like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return count; // 총 레코드 수 리턴
	}
}
