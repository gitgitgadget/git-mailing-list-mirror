From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] More build output cleaning up
Date: Wed, 7 Mar 2007 00:19:07 +0100
Message-ID: <81b0412b0703061519h17ddc517rb11499893dda6ac5@mail.gmail.com>
References: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiw5-0002BU-Gw
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbXCFXTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030686AbXCFXTK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:19:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:9538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030687AbXCFXTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:19:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so352271uga
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:19:07 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OdWIvOSd065z9x8c/0HJtTlz7UfQcGLPTKxQ8zGFpZfuU7iRbEYlx99N9KZo4oqSu7pUZwRkIwr8easI9g6aoKHYLHXokP6z+r/ZZinOuG1jVOfUuiLbeyMb8u4PEx093yBcFj+wPiH5lSepEwHifyi+S6ZqH3KW0mFeOJI8k8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lzVdpQd99H7mtudMEBazXOs8xa5DYLPO2FJdV+bYogTVwk81n0n1s+a1L3+pRe2hKrLBcfGbWx4KB3bpkeOq19ry+BKNhKluXClVL4XOJfMRzxf36PTzbJCBSgNej6bWsfnoePrBQ6LNS6qqtYC2Ab+OZ5hUwb9ydQVsJ+JgC54=
Received: by 10.78.171.20 with SMTP id t20mr655024hue.1173223147697;
        Tue, 06 Mar 2007 15:19:07 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:19:07 -0800 (PST)
In-Reply-To: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41617>

Oh, damn... I did it again. Stupid gmail...
I'll try to resend them from my home account, but that
probably wont work (it never did). Vger (or whatever else)
keeps dropping them.
