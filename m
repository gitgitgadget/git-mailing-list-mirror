From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: Problem with clone hanging
Date: Mon, 07 Aug 2006 11:23:20 -0700
Message-ID: <1154975000.26375.86.camel@sardonyx>
References: <1154968942.26375.23.camel@sardonyx>
	 <20060807171240.GA19907@harddisk-recovery.com>
	 <1154971295.26375.48.camel@sardonyx>
	 <20060807215201.b54da1ce.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 20:25:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA9kP-0005La-RC
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWHGSW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHGSW0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:22:26 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:23217 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932285AbWHGSWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 14:22:25 -0400
Received: from [127.0.0.1] (demesne.serpentine.com [192.168.16.11])
	by demesne.serpentine.com (Postfix) with ESMTP id A906A20B541;
	Mon,  7 Aug 2006 11:22:21 -0700 (PDT)
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20060807215201.b54da1ce.vsu@altlinux.ru>
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25023>

On Mon, 2006-08-07 at 21:52 +0400, Sergey Vlasov wrote:

> In the meantime, you can try to specify a local clone of the mainline
> Linux repository with the --reference=... option to git-clone. 

Thanks.  I don't know if what I'm cloning is actually a kernel tree,
unfortunately.

	<b
