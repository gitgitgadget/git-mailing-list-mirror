From: Thomas Koch <thomas@koch.ro>
Subject: is gitosis secure?
Date: Tue, 9 Dec 2008 09:56:48 +0100
Organization: Young Media Concepts
Message-ID: <200812090956.48613.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>, dabe@ymc.ch
X-From: git-owner@vger.kernel.org Tue Dec 09 09:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9yPz-0003hs-4d
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 09:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYLII4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 03:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYLII4y
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 03:56:54 -0500
Received: from koch.ro ([195.34.83.107]:55184 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752113AbYLII4x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 03:56:53 -0500
Received: from 80-218-105-106.dclient.hispeed.ch ([80.218.105.106] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1L9yOd-0008NS-Sz; Tue, 09 Dec 2008 09:56:48 +0100
User-Agent: KMail/1.9.9
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102609>

Sorry for the shameless subject, but I presented gitosis yesterday to
our sysadmin and he wasn't much delighted to learn, that write access to
repositories hosted with gitosis would need SSH access.

So could you help me out in this discussion, whether to use or not to
use gitosis? 
Our admin would prefer to not open SSH at all outside our LAN, but
developers would need to have write access also outside the office.

Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
