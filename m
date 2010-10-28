From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] git-branch.txt: mention --set-upstream as a way to
 change upstream configuration
Date: Thu, 28 Oct 2010 15:08:15 -0500
Message-ID: <20101028200815.GA16125@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-11-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 22:08:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYlz-000629-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761490Ab0J1UI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:08:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58042 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759802Ab0J1UIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 16:08:24 -0400
Received: by wwe15 with SMTP id 15so2435243wwe.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3+CTLfjN8m37U1FJrN4lCpAbIOX5PssxYj5FC4Zi2Z0=;
        b=OYzEclDGEox0UFtIwnfCHwH4W1M7+5REH114uIkj/KP6i+C7RtOGonsuRKC8jgvq+5
         P93s+WWmMcw4NXV7hK8gIq5miNa5RMwZX6jmKkjEwuTWYu8L1qIhv8Gemtj2ok+kShrO
         mpTs1SakiCbk00Y8pZ2iJizApQ2eo571lXG7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xNU5gNTBlt/sLZqicaRg+wuGU9CYRUlBVpPlbAlVKvqomTkAl35XCmxet43XH+gMEg
         WApo3p9AawOUGQXo/wVIEtqLTumD56eOXkUMj6MwkpN9GeU0CV4A0TLTfCf5txQNCHp5
         l0TB0hUcZEeEiWlU6RuKozAJeFNskX6r9am6U=
Received: by 10.227.59.133 with SMTP id l5mr5639224wbh.222.1288296502793;
        Thu, 28 Oct 2010 13:08:22 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id ga16sm1276881wbb.19.2010.10.28.13.08.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 13:08:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-11-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160218>

Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Patches 5, 9, and 10 look good, too.

Thanks again.
Jonathan
who is wishing his inbox were not so full.
