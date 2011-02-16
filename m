From: =?UTF-8?Q?Jo=C3=A3o_P=2E_Sampaio?= <jpmelos@jpmelos.com>
Subject: Need help grasping some concepts
Date: Tue, 15 Feb 2011 22:19:27 -0200
Message-ID: <AANLkTi=RfK13jUiu+tT21M-dm65tPrkr+s8asa+nZdak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 16 02:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpWR8-0001sT-Td
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 02:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929Ab1BPBn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 20:43:27 -0500
Received: from cpoproxy3-pub.bluehost.com ([67.222.54.6]:49537 "HELO
	cpoproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756794Ab1BPATb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 19:19:31 -0500
Received: (qmail 12114 invoked by uid 0); 16 Feb 2011 00:19:30 -0000
Received: from unknown (HELO box598.bluehost.com) (66.147.242.198)
  by cpoproxy3.bluehost.com with SMTP; 16 Feb 2011 00:19:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=jpmelos.com;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type:Content-Transfer-Encoding:X-Identified-User;
	b=Ke7nSg7ivn+XvgDbj0dZuj7W291XgCMNmbCFDspKmP3Qh+7xiMDOPHVTfKP4r0v81Y1/8w9jXN7inbBOHonX0sHFqIaNJuOas0OHdyKtlMtB/T76slqo8zZP62/PUHls;
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by box598.bluehost.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <jpmelos@jpmelos.com>)
	id 1PpV7B-0000Zi-Vu
	for git@vger.kernel.org; Tue, 15 Feb 2011 17:19:30 -0700
Received: by bwz15 with SMTP id 15so123422bwz.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 16:19:27 -0800 (PST)
Received: by 10.204.119.17 with SMTP id x17mr32786bkq.86.1297815567211; Tue,
 15 Feb 2011 16:19:27 -0800 (PST)
Received: by 10.204.4.133 with HTTP; Tue, 15 Feb 2011 16:19:27 -0800 (PST)
X-Identified-User: {2310:box598.bluehost.com:jpmelosc:jpmelos.com} {sentby:smtp auth 209.85.214.46 authed with jpmelos@jpmelos.com}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166912>

Hello, people.

I've been reading this list for quite a while now, and trying to
understand what's going on, and wandering around in the code.

There are some concepts I'd like you to help me understand better:

1) What are plumbing and porcelain functions, methods, APIs... What's
the meaning of that classification and difference between the two?

2) What's going on about cache-tree not being able to handle empty
trees, or something like that? You mean Git doesn't store empty
directories in repositories?

3) And what are symbolic references? Are they just an alias I can
attach to branches and tags, like symbolic links in Linux that I can
attach to folders and files?

If you prefer, just a link to some material I can read to understand
those concepts better would be great. :)

Thank you very much!

--=20
Jo=C3=A3o Paulo Melo de Sampaio
Computer Engineering Student @ UFSCar
Website: http://www.jpmelos.com
Twitter: twitter.com/jpmelos (@jpmelos)
