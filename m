From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 15:08:38 -0800
Message-ID: <20051123230838.GN3968@reactrix.com>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 24 00:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef3jM-0000Oy-0x
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbVKWXIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVKWXIo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:08:44 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:30630 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030486AbVKWXIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:08:43 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jANN8cBW010444
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 15:08:38 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jANN8ct7010442
	for git@vger.kernel.org; Wed, 23 Nov 2005 15:08:38 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051123211601.GA2260@hpsvcnb.fc.hp.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12656>

On Wed, Nov 23, 2005 at 02:16:01PM -0700, Carl Baldwin wrote:

> It might be cool to enable cloning to a remote over ssh if the remote
> doesn't yet exist.

I would like to see the same for http.  There is limited support for
managing a repository using http but without the ability to run tools
like init-db/clone/update-server-info you still need shell access
or some other workaround.  I think it would be useful to allow someone
to create, manage, and share a repository without any special
intelligence on the server side.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
