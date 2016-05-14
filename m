From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Git and Mozaik
Date: Sat, 14 May 2016 10:10:43 -0400
Message-ID: <00bb01d1adea$6b419e30$41c4da90$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	boundary="----=_NextPart_000_0098_01D1AD46.AB804040";
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git mailing list'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 16:11:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1aI9-00027q-K1
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 16:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcENOLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 10:11:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:47814 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcENOLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 10:11:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u4EEArAe081164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 14 May 2016 10:10:54 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGHdoQaxWpBX7hQdNvdAf8TjogxOQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294613>

Hi Everyone,

I'm embarking on a bit of a quest to bring git into a CNC manufacturing
environment for the Mozaik software package. Does anyone in the group have
experience with git for that package (expecting probably not, but I had to
ask)? I'm hoping that there won't be too many problems (internal file format
seems relatively compatible for the stuff that needs to be versioned
although if there are one-liner text files it may be annoying and I may have
to provide my own diff engine).

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
