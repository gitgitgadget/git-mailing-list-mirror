From: youngseonkim <1.youngsun.kim@gmail.com>
Subject: git svn clone not work. It's stop with no error message.
Date: Sun, 16 Feb 2014 23:45:14 -0800 (PST)
Message-ID: <1392623113974-7603785.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 08:45:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFItJ-0000fQ-03
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 08:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbaBQHpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 02:45:17 -0500
Received: from sam.nabble.com ([216.139.236.26]:58367 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbaBQHpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Feb 2014 02:45:16 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <1.youngsun.kim@gmail.com>)
	id 1WFIt8-0001Vj-2I
	for git@vger.kernel.org; Sun, 16 Feb 2014 23:45:14 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242246>

Hi, I really wonder about this happen.
I want svn=E2=86=92git migrate, and I use this command.

git svn clone https://my.svn.repo/url --stdlayout

When I test a small svn repository and 'real working repository 1' with=
 same
this command, it's complete successfully.
But it's not work in a 'real working repository 2', it just stop sudden=
ly.

CMD console not shown any error message, last message are like this.

r1 =3D 67f4093b82b7b764171b01f1566eca57f6c29ac2

I don't know about why this process stop.. 'real repository 2' configur=
ed
same with 'real repository 1'.
'Real working repository 2' are very large but I don't know accurate si=
ze..
I working on Windows server 2008, 16GB RAM memory, 16 cores cpu, upper =
then
100GB hard disk space.

I'm sorry. I'm not speak English well. But I really want someone help m=
e..
Anybody have some idea about this happen?



--
View this message in context: http://git.661346.n2.nabble.com/git-svn-c=
lone-not-work-It-s-stop-with-no-error-message-tp7603785.html
Sent from the git mailing list archive at Nabble.com.
