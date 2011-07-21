From: larsh-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
Subject: [ANNOUNCE] CGIT 0.9.0.2
Date: Thu, 21 Jul 2011 14:33:11 +0000
Message-ID: <20110721143311.GA19358@hjemli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
X-From: cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org Thu Jul 21 16:29:47 2011
Return-path: <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>
Envelope-to: gcvc-cgit@m.gmane.org
Received: from li195-143.members.linode.com ([178.79.139.143] helo=hjemli.net)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
	id 1QjuG2-0004O5-QC
	for gcvc-cgit@m.gmane.org; Thu, 21 Jul 2011 16:29:46 +0200
Received: from localhost ([127.0.0.1] helo=node.hjemli.net)
	by hjemli.net with esmtp (Exim 4.74)
	(envelope-from <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
	id 1QjuJN-00053E-4j; Thu, 21 Jul 2011 14:33:13 +0000
Received: from larsh by hjemli.net with local (Exim 4.74)
 (envelope-from <larsh-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
 id 1QjuJL-000538-Mk; Thu, 21 Jul 2011 14:33:11 +0000
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
X-BeenThere: cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: list for cgit developers and users <cgit.hjemli.net>
List-Unsubscribe: <http://hjemli.net/mailman/options/cgit>,
 <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://hjemli.net/pipermail/cgit>
List-Post: <mailto:cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>
List-Help: <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=help>
List-Subscribe: <http://hjemli.net/mailman/listinfo/cgit>,
 <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=subscribe>
Errors-To: cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org

A bugfix release of cgit (a web interface to git repositories) is now
available from http://hjemli.net/git/cgit

$ git shortlog v0.9.0.1..v0.9.0.2
Eric Wong (1):
      html.c: avoid out-of-bounds access for url_escape_table

Ferry Huberts (1):
      tests: fix failures when CDPATH is set

Lars Hjemli (5):
      README: update some stale information/add some new
      cgitrc.5.txt: describe macro expansion of cgitrc options
      cgitrc.5.txt: document repo.module-link
      cgit.c: improve error message when git repo cannot be accessed
      CGIT 0.9.0.2
