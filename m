From: James French <James.French@naturalmotion.com>
Subject: running git from non-standard location on Mac
Date: Thu, 21 Feb 2013 09:48:36 +0000
Message-ID: <1CE1BECC0915A6448EAE5D7080EDA905052078C95E@oxexc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 10:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Sm0-0005WN-N3
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 10:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab3BUJsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 04:48:40 -0500
Received: from gwl205.naturalmotion.com ([86.12.140.205]:57927 "EHLO
	mail1.naturalmotion.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752379Ab3BUJsi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 04:48:38 -0500
Thread-Topic: running git from non-standard location on Mac
Thread-Index: Ac4QGJ6mHT0XKAqQQc25ilPzuWVV/A==
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216762>

Hi,

I wonder if someone could help me. I installed git on a Mac and then I =
copied the install somewhere else (which I do want to do, trust me). =A0=
I'm now having trouble with git svn. I'm getting "Can't locate Git/SVN.=
pm in @INC..."

I've added the bin folder to PATH. What else do I need to do? Do I need=
 to use -exec-path=3D/MyPathToGit/libexec/git-core? How do I change the=
 content of @INC?

Apologies if this is a dumb question, I'm not much of a unix man.

Cheers,
James
