From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: Two gitweb feature requests
Date: Thu, 27 Apr 2006 22:54:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0604272250420.4963@mundungus.clifford.ac>
References: <1146144425.11909.450.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1152309293-1384283113-1146178486=:4963"
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 00:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZFPw-0004aR-5w
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWD0W45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWD0W45
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:56:57 -0400
Received: from mundungus.clifford.ac ([81.187.211.39]:6930 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751689AbWD0W44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 18:56:56 -0400
Received: from mundungus.clifford.ac (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k3RMuCZa002871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Apr 2006 22:56:12 GMT
Received: from localhost (benc@localhost)
	by mundungus.clifford.ac (8.13.3/8.13.3/Submit) with ESMTP id k3RMu9WR002867;
	Thu, 27 Apr 2006 22:56:11 GMT
X-Authentication-Warning: mundungus.clifford.ac: benc owned process doing -bs
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1146144425.11909.450.camel@pmac.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19252>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1152309293-1384283113-1146178486=:4963
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 27 Apr 2006, David Woodhouse wrote:

> It would be useful if I could get away with giving just one URL --
> probably the http:// one to gitweb. If gitweb were to have a mode in
> which it gave a referral to the git:// URL, and if the git tools would
> use that, then that would work well.

HTML has a <link> element which can be used to indicate alternate forms of=
=20
a page. Gitweb already generates one already to point people at the RSS=20
feeds.

Kinda messy to make all the git tools learn how to read HTML, though...

--=20
Ben =E3=81=B9=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/

---1152309293-1384283113-1146178486=:4963--
