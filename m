From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Post-1.5.4 stuff: builtin-checkout
Date: Mon, 17 Dec 2007 11:30:58 -0500
Message-ID: <1197909058.8688.2.camel@hinata.boston.redhat.com>
References: <Pine.LNX.4.64.0712151529300.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4IsW-0004OO-HK
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759832AbXLQQbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759681AbXLQQbH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:31:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759379AbXLQQbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:31:05 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBHGV4VN031484;
	Mon, 17 Dec 2007 11:31:04 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGV3Fd010216;
	Mon, 17 Dec 2007 11:31:03 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGV3t1022140;
	Mon, 17 Dec 2007 11:31:03 -0500
In-Reply-To: <Pine.LNX.4.64.0712151529300.5349@iabervon.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68577>


On Sat, 2007-12-15 at 15:44 -0500, Daniel Barkalow wrote:
> I've got my builtin-checkout implementation at:
> 
>  git://iabervon.org/~barkalow/git.git builtin-checkout
> 
> This may be interesting to some other people at this point, despite it not 
> being relevant to 1.5.4, because (a) it includes a slew of small 
> preliminary patches to other stuff that might be useful for making other 
> things builtin and (b) these changes reflect my debugging of my naive 
> implementation of builtin-checkout, and may suggest things that might be 
> wrong in existing builtins that do multiple operations in the same 
> process.

Thanks, fetching it now.

Kristian
