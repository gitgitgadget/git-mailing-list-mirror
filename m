From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: Problem with clone hanging
Date: Mon, 07 Aug 2006 10:21:35 -0700
Message-ID: <1154971295.26375.48.camel@sardonyx>
References: <1154968942.26375.23.camel@sardonyx>
	 <20060807171240.GA19907@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tziporet Koren <tziporet@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Aug 07 19:21:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA8mb-0007zm-Q3
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 19:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHGRUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHGRUm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 13:20:42 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:48319 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932236AbWHGRUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 13:20:41 -0400
Received: from [127.0.0.1] (demesne.serpentine.com [192.168.16.11])
	by demesne.serpentine.com (Postfix) with ESMTP id 9353220B541;
	Mon,  7 Aug 2006 10:20:37 -0700 (PDT)
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060807171240.GA19907@harddisk-recovery.com>
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25021>

On Mon, 2006-08-07 at 19:12 +0200, Erik Mouw wrote:

> Looks like the same problem that kernel.org used to have. The other
> side probably runs git-1.4.0, they should upgrade to 1.4.1.

OK, thanks for the helpful response.

>  In the mean
> time, you could clone using http and later on switch to git transport.

It seems like Mellanox doesn't publish that repository over HTTP, so I'm
stuck.  Tziporet, can you upgrade your git installation, please?

	<b
