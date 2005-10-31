From: Lexington Luthor <Lexington.Luthor@gmail.com>
Subject: git objects directory
Date: Mon, 31 Oct 2005 15:33:44 +0000
Message-ID: <dk5dgq$isv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 31 16:57:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWbzJ-0007kf-Ow
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 16:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVJaPyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 10:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJaPyK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 10:54:10 -0500
Received: from main.gmane.org ([80.91.229.2]:27793 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932326AbVJaPyI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 10:54:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EWbw3-0006aS-TZ
	for git@vger.kernel.org; Mon, 31 Oct 2005 16:51:00 +0100
Received: from bb-82-108-13-253.ukonline.co.uk ([82.108.13.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 16:50:59 +0100
Received: from Lexington.Luthor by bb-82-108-13-253.ukonline.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 16:50:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.6a1 (Windows/20051030)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10859>

Hi,

Can someone please explain why git puts its objects in 256 
sub-directories of objects instead of directly in the objects directory 
itself? I am trying to learn git (actually cogito), but I still don't 
understand  why this structure is used.

What is the point of having the first byte of the hash as the directory 
name?

-- LL
