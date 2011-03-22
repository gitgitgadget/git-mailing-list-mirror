From: madmarcos <fru574@my.utsa.edu>
Subject: Re: calculating a git packfile sha1 checksum in java
Date: Tue, 22 Mar 2011 13:58:26 -0700 (PDT)
Message-ID: <1300827506173-6197923.post@n2.nabble.com>
References: <1300786044816-6195501.post@n2.nabble.com> <AANLkTimWt4P3qtR3b6YfRJ=Tx69EL+9+oXhD_2c9O6JX@mail.gmail.com> <AANLkTiniKOzzwZhJ5GN4nf8AWRTsT6bbMeK4s5XqvH42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 21:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q28ev-0001Ow-RX
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 21:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab1CVU62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 16:58:28 -0400
Received: from sam.nabble.com ([216.139.236.26]:47739 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab1CVU61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 16:58:27 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1Q28eo-0000Gj-5o
	for git@vger.kernel.org; Tue, 22 Mar 2011 13:58:26 -0700
In-Reply-To: <AANLkTiniKOzzwZhJ5GN4nf8AWRTsT6bbMeK4s5XqvH42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169775>

Hi Shawn,
Thanks for the response!
I looked at the JGit API. will it allow me to read a packfile, alter its
contents, and repack it?
regards,
Mark

--
View this message in context: http://git.661346.n2.nabble.com/calculating-a-git-packfile-sha1-checksum-in-java-tp6195501p6197923.html
Sent from the git mailing list archive at Nabble.com.
