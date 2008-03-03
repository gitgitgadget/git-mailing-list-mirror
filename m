From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Unknown option: no-signed-off-by-cc (git-send-email)
Date: Mon, 03 Mar 2008 12:32:03 -0600
Message-ID: <47CC4423.8020109@freescale.com>
References: <47CC21F7.3020204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:33:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFT7-0007fb-7L
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYCCScT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYCCScT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:32:19 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:42850 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYCCScS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:32:18 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m23IWFMO002847
	for <git@vger.kernel.org>; Mon, 3 Mar 2008 11:32:16 -0700 (MST)
Received: from [10.214.72.228] (mvp-10-214-72-228.am.freescale.net [10.214.72.228])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m23IWDHL024953;
	Mon, 3 Mar 2008 12:32:13 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47CC21F7.3020204@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75964>

Timur Tabi wrote:
> I just upgraded to 1.5.4, and when I tried to use git-send-email with my usual
> parameters, I got this:
> 
> Unknown option: no-signed-off-by-cc
> git-send-email [options] <file | directory>...
> 
> The documentation for git-send-email still lists this option.
> 

Except that the "no" and "signed" are not separated by "-".

jdl
