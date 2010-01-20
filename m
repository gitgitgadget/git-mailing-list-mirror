From: Richard Assal <richard_assal@yahoo.com>
Subject: git equivalent to clearcase wink-in
Date: Wed, 20 Jan 2010 12:20:37 -0800 (PST)
Message-ID: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 21:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXh2h-0001QT-99
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab0ATUUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 15:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058Ab0ATUUj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:20:39 -0500
Received: from n68.bullet.mail.sp1.yahoo.com ([98.136.44.44]:35640 "HELO
	n68.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753564Ab0ATUUi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:20:38 -0500
Received: from [216.252.122.216] by n68.bullet.mail.sp1.yahoo.com with NNFMP; 20 Jan 2010 20:20:38 -0000
Received: from [98.136.44.164] by t1.bullet.sp1.yahoo.com with NNFMP; 20 Jan 2010 20:20:38 -0000
Received: from [127.0.0.1] by omp605.mail.sp1.yahoo.com with NNFMP; 20 Jan 2010 20:20:38 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 44774.97428.bm@omp605.mail.sp1.yahoo.com
Received: (qmail 84225 invoked by uid 60001); 20 Jan 2010 20:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1264018837; bh=iZp/h60R1UckmcbCTo1hvfQnCHgqyBTBIKYl1YoO/OM=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=VgQBqJMujBRE2qPhd+DjK/28pFV6DOJr5lpTAkgsIkzzyYLbXV8RB9PeI+6GcVEDo2XTGzqHWX2q6DEKuS5qIgxMq0q7Ur0toHho7v+bWVbWFAKLU5Ri1RrYt/VdYpn3iTC5Kc7Wf8JHWl52f/2Bm6bUggweS+YFytuzu/TliSs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GdDOT2FJ7bR1kVfixZi8wKLZxYVRYB0/nUxHErUQrYOFO7Bgl86CHL8QjBLDXZ9G6ol1urQ0SfUq5QqIgdWciSv9JH2EzeSSwwoBvCd+5B5RVU0gF3Hed9MWp9SFnJiN+D0yZr5Qrw52iI+BMePnFfa0E9ab6q18olQWG+aqNEY=;
X-YMail-OSG: MOFekZoVM1nXR_Ii7FckiVWP44m3xgoDo92QpcxB9_BLz5T2GhJxC8tqwnfQ2WsBXtu79Rk.AFm9WaWmRolICRc1RY7A5hqNgxvFKyZUhCbpn3859t9EN6VTEAUihtL3epEEbwkQeLpY0lajG4GcIJQDVq_xLxaPFz028YzB6Qz8aG0ZBPpl8gYI1YfV0aYJLXPbRusfXCK9tni_xCEomBhtZxarN1FEHL27rhUlSJ3eSH1RkHGPHSCflfv25FLhjaLK0zVzMs9HfjFWiuY533VSLl4K3_Rb2QhpOIFIebeVZFGu3Zg-
Received: from [167.225.107.17] by web45111.mail.sp1.yahoo.com via HTTP; Wed, 20 Jan 2010 12:20:37 PST
X-Mailer: YahooMailRC/272.7 YahooMailWebService/0.8.100.260964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137568>

To whom it may concer,

I have been playing with git recently, and I like it very much.=A0 I wa=
s wondering if you can tell me if git has something that is equivalent =
to clearcase wink-in functionality.=A0 The reason I ask, if it takes 1 =
hour to build my repository, then every=A0clone of my repository will a=
lso take one hour to build at the remote location.=A0 In clearcase you =
can wink in objects that have already been built.=A0 time to wink in co=
uld just be minutes rather than waiting a full hour for all the binarie=
s to build.

Can you help me out here?=A0 I would like to know if git has something =
similar.

Richard.


     =20
