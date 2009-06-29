From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Merge, rebase and whitespace fixes
Date: Mon, 29 Jun 2009 23:30:47 +0200
Message-ID: <4A493287.20106@dawes.za.net>
References: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOSU-0002yv-2P
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZF2VcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZF2VcC
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:32:02 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:34122 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbZF2VcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:32:00 -0400
Received: from homiemail-a14.g.dreamhost.com (caiajhbdcbhh.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id CB5141842D5
	for <git@vger.kernel.org>; Mon, 29 Jun 2009 14:32:04 -0700 (PDT)
Received: from artemis.local (dsl-246-34-245.telkomadsl.co.za [41.246.34.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 682CC8C062;
	Mon, 29 Jun 2009 14:30:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122461>

Giuseppe Bilotta wrote:
> Hello all,
> 
> recently a tree I've been working on received some thorough whitespace
> adjustments (changing indents from spaces to tabs). This results in
> annoying conflicts when running merges or rebases with my local
> branches. I tried googling around but I couldn't find any helpful
> hints on how to make git cope with this. Any suggestions?
> 

Do the same thing to your own tree?
