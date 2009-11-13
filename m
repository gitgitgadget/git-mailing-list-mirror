From: Shameem Ahamed <shameem.ahamed@yahoo.com>
Subject: Warning while cloning remote repository
Date: Fri, 13 Nov 2009 15:50:29 +0530 (IST)
Message-ID: <117260.55181.qm@web94705.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 11:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8tGf-0004ju-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 11:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbZKMKU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 05:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbZKMKU0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 05:20:26 -0500
Received: from web94705.mail.in2.yahoo.com ([203.104.17.150]:45351 "HELO
	web94705.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755744AbZKMKU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 05:20:26 -0500
Received: (qmail 55193 invoked by uid 60001); 13 Nov 2009 10:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1258107630; bh=QE8DZVmXzzTMsaBqW5Wo7+oacOnDbl79fCxqdtk9JAs=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=wFfBiw377J5gH89K86JFaZTgeJx9DuddkLBGR32q9WkJUNYlIUdic90o012OPGb6lBcyPCva5/BYUT6ZXeN4p6/X3QB8Jea4e7c2+LyO2xsn8g9AqK16KlyJMZIVSpSPpbDrsguCybnVbkBZx42+vz65ah5FRczobJgYEsS7k5w=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=YA/GceB9VB0tbz5nC3dSYXtIGY8vA+f6+ypdpRwWjE2ZUUB7ahePO6Ib9PND76JZaY7tTzZ7p+fJ/pa9UwIs2bV02NSdZM6ZBsy6C++R8D6gvBqhlbmRa+CZ91IPBAQwmpYGSiGGJXRgbApEHgCv7KBiBn9zizbhCgBtB8jMYrg=;
X-YMail-OSG: 0FRUwvIVM1mbQCAezSGSxmZjZljATLX2ZPLWjwqh5ZNiSeQnpu.RnuAlThtlvqU66k6_esQMiJqdF8rLoZYGYmMKVQExx0dosJ4ofC9XBgFXL09_AVc6iknOAoO6W23SgrtsaqqaBfJLLwEwRV75MeLmGoC1g.eI1ZRV7HlfoUd6XY.BYdsTsRMLefB7T8HBs95DtjRyI3aVFVsFiMpKoh5Rxv3B2BIosd6WiiJay6hKsiRyvNjCJLBxCc9d8nVXGNU-
Received: from [122.181.8.86] by web94705.mail.in2.yahoo.com via HTTP; Fri, 13 Nov 2009 15:50:29 IST
X-Mailer: YahooMailRC/211.6 YahooMailWebService/0.7.361.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132831>

Hi,

I ran in to a warning message while cloning a remote repository.

The message is 

warning: remote HEAD refers to nonexistent ref, unable to checkout.

After the cloning i couldn't see any remote files. The .git folder is created successfully.

Regards,
Shameem



      
