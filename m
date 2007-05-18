From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 18:31:34 +0300
Message-ID: <20070518153134.GM4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180857.18182.andyparkins@gmail.com>
	<200705181043.09203.Josef.Weidendorfer@gmx.de>
	<200705181021.30062.andyparkins@gmail.com>
	<20070518110804.GD4708@mellanox.co.il>
	<20070518151044.2FC05111E33@yugib.highrise.ca>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Andy Parkins <andyparkins@gmail.com>
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Fri May 18 17:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp4Qy-0000yY-My
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbXERPbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756042AbXERPbz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:31:55 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34261 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbXERPby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 11:31:54 -0400
Received: by py-out-1112.google.com with SMTP id a29so1191152pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 08:31:54 -0700 (PDT)
Received: by 10.65.213.4 with SMTP id p4mr6626601qbq.1179502291662;
        Fri, 18 May 2007 08:31:31 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id d12sm4093776qbc.2007.05.18.08.31.29;
        Fri, 18 May 2007 08:31:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070518151044.2FC05111E33@yugib.highrise.ca>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47617>

> Again - if *I* create a project, and decide to use a particular key for a
> subproject, then good.  If *you* create a project and decide to use a
> particular key for a subproject, then good. 
> 
> If you clone *my* superproject, you get *my* choice of key.  If I clone
> *your* superproject, I get *your* choice of key.

Absolutely. What I object to is using this key in clients
as a hint for where to get the objects.
This *must* be overridable by me, without creating commits.

-- 
MST
