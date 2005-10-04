From: Greg KH <greg@kroah.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 14:07:06 -0700
Message-ID: <20051004210706.GA16161@kroah.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <200510032048.37363.alan@chandlerfamily.org.uk> <43419DD4.5040508@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 23:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMu1P-0000jG-In
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 23:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVJDVHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVJDVHo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 17:07:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:48554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964976AbVJDVHn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 17:07:43 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j94L7Nw27811;
	Tue, 4 Oct 2005 14:07:24 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1EMu0A-4Cx-00; Tue, 04 Oct 2005 14:07:06 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43419DD4.5040508@zytor.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9688>

On Mon, Oct 03, 2005 at 02:08:36PM -0700, H. Peter Anvin wrote:
> 
> I believe in the medium-to-long term a plugin architecture for merging 
> is imperative.  It's not even different media types, but some *files* 
> have specific merging policies.  Think, for example, of pci.ids in the 
> Linux kernel tree.

You mean the file that is now removed from the kernel tree?  Sure,
that's a good merge policy :)

greg k-h
