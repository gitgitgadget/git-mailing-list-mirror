From: Josh Triplett <josh@freedesktop.org>
Subject: Re: most commonly used git commands?
Date: Wed, 27 Jun 2007 18:37:24 -0700
Message-ID: <468310D4.2070504@freedesktop.org>
References: <20070625064017.GA2839@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Jun 28 03:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3iyH-0003Y3-Qh
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 03:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760613AbXF1Bik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 21:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759078AbXF1Bik
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 21:38:40 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:34591 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758817AbXF1Bij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 21:38:39 -0400
Received: (qmail 30162 invoked from network); 28 Jun 2007 01:38:38 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <mst@dev.mellanox.co.il>; 28 Jun 2007 01:38:38 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <20070625064017.GA2839@mellanox.co.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51071>

Michael S. Tsirkin wrote:
> I did this by mistake:
> 
> $git fet linux-2.6
> git: 'fet' is not a git-command
> 
> The most commonly used git commands are:
>    add     Add file contents to the changeset to be committed next
>    apply   Apply a patch on a git index file and a working tree
> (use 'git help -a' to get a list of all installed git commands)

It should have listed more than just those two...

- Josh Triplett
