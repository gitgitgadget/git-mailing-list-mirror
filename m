From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Sat, 19 May 2007 21:12:28 +0300
Message-ID: <20070519181228.GP4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180141.06862.Josef.Weidendorfer@gmx.de>
	<200705180857.18182.andyparkins@gmail.com>
	<200705181043.09203.Josef.Weidendorfer@gmx.de>
	<7vejle6p96.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Nicolas Pitre <nico@cam.org>,
	Steven Grimm <koreth@midwinter.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 20:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpTQ9-0000px-Ba
	for gcvg-git@gmane.org; Sat, 19 May 2007 20:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXESSM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbXESSM2
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 14:12:28 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:57266 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbXESSM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 14:12:27 -0400
Received: by py-out-1112.google.com with SMTP id a29so1453360pyi
        for <git@vger.kernel.org>; Sat, 19 May 2007 11:12:26 -0700 (PDT)
Received: by 10.64.153.4 with SMTP id a4mr8404589qbe.1179598346549;
        Sat, 19 May 2007 11:12:26 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id a5sm5156694qbd.2007.05.19.11.12.23;
        Sat, 19 May 2007 11:12:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vejle6p96.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47761>

> Fetching from a new URL (not just "different from what is
> defined in .gitmodules") is a major deal from security point of
> view (you should not fetch from stranger you do not trust).

I'm sorry, I'm confused. I thought the "URL" in .gitmodules
is just a unique project key/name? So how come you are now
speaking about fetching from it?

-- 
MST
