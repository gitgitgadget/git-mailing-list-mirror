From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Tue, 20 Oct 2009 19:09:05 +0200
Message-ID: <4ADDEEB1.80107@dirk.my1.cc>
References: <20091019195456.GA11121@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ICy-0002Mh-Nq
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 19:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbZJTRJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 13:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZJTRJD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 13:09:03 -0400
Received: from smtprelay07.ispgateway.de ([80.67.29.7]:57196 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbZJTRJD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 13:09:03 -0400
Received: from [84.176.127.162] (helo=[192.168.2.100])
	by smtprelay07.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1N0IDf-0002iL-Lo; Tue, 20 Oct 2009 19:09:59 +0200
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091019195456.GA11121@unpythonic.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130816>

Am 19.10.2009 21:54 schrieb Jeff Epler:
> When applying less than a full hunk, it's still often desirable to apply
> a number of consecutive lines.
> 
> This change makes it possible to sweep out a range of lines in the diff view
> with the left mouse button, then right click and "Stage Lines For Commit".
> 
> The selected lines may span multiple hunks.
> 

Awesome! I've been waiting for that very feature. Thanks in advance.
-- Dirk
