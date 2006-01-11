From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Proxy and authentication
Date: Wed, 11 Jan 2006 10:51:22 -0800
Message-ID: <20060111185122.GA3873@reactrix.com>
References: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 19:52:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewl4S-0006hp-6t
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 19:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWAKSv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWAKSv0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 13:51:26 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:2808 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932620AbWAKSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 13:51:25 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k0BIpN6g017628;
	Wed, 11 Jan 2006 10:51:23 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k0BIpMIg017626;
	Wed, 11 Jan 2006 10:51:22 -0800
To: Beber <beber.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14497>

On Wed, Jan 11, 2006 at 03:53:23PM +0100, Beber wrote:

> Is there plan to allow proxy authentication and http/webdav remote
> repository authentication ?

You can use .netrc for HTTP auth credentials, but I don't believe that
handles proxy authentication.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
