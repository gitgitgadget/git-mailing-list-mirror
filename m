From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 14:53:41 +1300
Message-ID: <46a038f90801211753p3baebb61y5ed5f389d5151168@mail.gmail.com>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se>
	 <20080121204614.GG29792@mit.edu>
	 <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
	 <20080121211802.GH29792@mit.edu>
	 <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
	 <46a038f90801211349mfb57c0an9416832c2967c172@mail.gmail.com>
	 <BA2377B5-BE7E-40F2-9C3C-679663A966A4@sb.org>
	 <alpine.LSU.1.00.0801220031490.5731@racer.site>
	 <32CA7B5D-FED0-4C70-A7DE-14E24B74FD1F@sb.org>
	 <alpine.LSU.1.00.0801220128030.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH8L8-0003uD-7p
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbYAVBxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbYAVBxp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:53:45 -0500
Received: from hu-out-0506.google.com ([72.14.214.238]:18563 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbYAVBxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 20:53:44 -0500
Received: by hu-out-0506.google.com with SMTP id 19so914227hue.21
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sD7dxV7dDTY7uJhYpE7UAFJWaRMUSmbvRoMTgk9dSZ4=;
        b=FoqEio2PfwZ7bRDMvH8o+dKucuJRSsDR8o8ojr0PoUHpg2g6j9zNh1mBx7zBfStr7IeZlqdiWrvf/46ijgwLThMHRhe3+4rqVBbmkNTuhZOPmih8ww9LXcsFRdNXeak3LyzBsBMPTcYsdrS1KSIU52e4/imxMzGq/25JEFAgKeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sUyfx6rpCsu/QC7iVs9SNtwctIQWCPoIxYujQo3Buc+HZxg9dH4OhhTCfgfxmLafQ5XVv1dEDdG+xIBBn3nklGWixBmpTVmZw8PDbcFGElkdT91lXMvYfgUM+QRn7UObK1SU9TzqHGWA4AAh5Vjiu0T8pDBfbEvB+qNcbRGBC2c=
Received: by 10.67.15.6 with SMTP id s6mr5354149ugi.82.1200966821511;
        Mon, 21 Jan 2008 17:53:41 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 17:53:41 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801220128030.5731@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71398>

On Jan 22, 2008 2:34 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

Hey guys. Let's stop right here -- Kevin has perhaps been annoying but
this is a *technical* argument, so let's go back to working code.

Anyone send a patch to clear the air? *please*?





m
