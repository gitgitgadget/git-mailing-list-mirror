From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 17:53:44 -0800 (PST)
Message-ID: <20051122015344.63368.qmail@web31809.mail.mud.yahoo.com>
References: <43821BE7.5000306@michonline.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 02:56:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeNLx-0003xH-9V
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 02:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVKVBxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 20:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVKVBxq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 20:53:46 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:2203 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964856AbVKVBxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 20:53:45 -0500
Received: (qmail 63370 invoked by uid 60001); 22 Nov 2005 01:53:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qNecVWmEUCPSfa21+Fy3meBJd7xbxDQ2dMn1bNFL+nH+2LrfM+wXcUIH209GOnaGzL5Uf8cp49xQPm1Px1hNJIYQ4fVS325HE+KWG+nvPn/iia1tI28yp/0F1VUc7qyBceDPYhaUdXIehaQdDeCxZGXotA0yqK0ev+6LBjJXbN8=  ;
Received: from [68.221.112.229] by web31809.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 17:53:44 PST
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43821BE7.5000306@michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12514>

--- Ryan Anderson <ryan@michonline.com> wrote:

> Doesn't git-format-patch $commit^1..$commit do what you want?
> 

Yes, this is the one.  Thanks!

    Luben
