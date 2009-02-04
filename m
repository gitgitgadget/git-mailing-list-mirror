From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git diff and getting a list of files which have diffs
Date: Wed, 04 Feb 2009 16:39:45 -0600
Message-ID: <498A1931.4000606@freescale.com>
References: <dac45060902041435m3f884475j7f359ee694048ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Ryden <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqQn-0007V6-2d
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbZBDWju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756782AbZBDWju
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:39:50 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:46866 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688AbZBDWjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:39:49 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n14MdlVC028350;
	Wed, 4 Feb 2009 15:39:48 -0700 (MST)
Received: from [127.0.0.1] (mvp-10-214-72-222.am.freescale.net [10.214.72.222])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n14Mdjxi024093;
	Wed, 4 Feb 2009 16:39:47 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <dac45060902041435m3f884475j7f359ee694048ee5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108448>

Mark Ryden wrote:
> Hello,
> git diff shows the differneces between a tree and the working tree.
> Is there a way to get only the list of file names that have such differences
> without getting the differences themselves ?
> Rgs,
> Mark

--name-only ?

jdl
