From: Daniel Stenberg <dast@haxx.se>
Subject: Re: compiling git on debian
Date: Tue, 16 Jun 2009 13:57:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0906161353290.26547@yvahk2.pbagnpgbe.fr>
References: <f46c52560906160406t910f5f3v4040525531ad78c4@mail.gmail.com>  <alpine.DEB.2.00.0906161309370.14053@yvahk2.pbagnpgbe.fr> <f46c52560906160419g25f43ed0g253aff35031faf2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGXU9-0003fb-LR
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbZFPMJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 08:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbZFPMJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:09:16 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:52481 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbZFPMJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:09:16 -0400
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2009 08:09:15 EDT
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n5GBtmnI030833;
	Tue, 16 Jun 2009 13:55:48 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <f46c52560906160419g25f43ed0g253aff35031faf2d@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121676>

On Tue, 16 Jun 2009, Rustom Mody wrote:

>> libcurl4-openssl-dev: /usr/bin/curl-config
>>
>> (or you can opt to get the gnutls version if you prefer that)
>
> Ja Thats what I observed that libcurl-openssl-dev, libcurl-gnutls-dev both 
> seem to supply curl-config. So are both interchangeable?

I believe that's the idea, yes.

-- 

  / daniel.haxx.se
