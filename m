From: =?UTF-8?B?VGFkZXVzeiBBbmRyemVqIEthZMWCdWJvd3NraQ==?= 
	<yess@hell.org.pl>
Subject: [PATCH v2 0/2] Documentation: filter-branch env-filter example
Date: Thu, 21 Feb 2013 21:21:38 +0100
Message-ID: <512681D2.6020902@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 21:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8ceb-0003Yt-3A
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab3BUUVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 15:21:40 -0500
Received: from hell.org.pl ([213.135.50.122]:57409 "EHLO hell.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab3BUUVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:21:39 -0500
Received: from [10.2.0.23] (unknown [193.107.214.17])
	by hell.org.pl (Postfix) with ESMTP id 91EC1F0082
	for <git@vger.kernel.org>; Thu, 21 Feb 2013 21:21:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216791>

Hello,

Indeed the use case proposed by Junio C. Hamano is more realistic than =
mine.

I also included a minor clarification of how identity environment varia=
bles are
used to cover the edge case raised by Jeff King. As far as the need to =
export
those variables goes, I saw the wrong behavior on Solaris.

--=20
Tadeusz Andrzej Kad=C5=82ubowski
