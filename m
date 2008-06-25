From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Wed, 25 Jun 2008 16:38:30 +0200
Message-ID: <20080625143821.GA2588@dualtron.vpn.rwth-aachen.de>
References: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Ifejinelo Onyiah <nelo.onyiah@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 16:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBW9m-0005ub-56
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 16:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbYFYOie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 10:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbYFYOid
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 10:38:33 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:34585 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924AbYFYOic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 10:38:32 -0400
Received: from u-7-083.vpn.rwth-aachen.de ([137.226.103.83]:42848 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1KBW8j-0000i8-Ut; Wed, 25 Jun 2008 16:38:30 +0200
Content-Disposition: inline
In-Reply-To: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 137.226.103.83
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86281>

On 25/06/08 14:20, Ifejinelo Onyiah wrote:
> I have made several attempts to build Git (version 1.5.6) on my Mac OS
> X 10.4.11 (Tiger) but have had little luck. At the time of my last try
>  (2008-06-25 11:08) there were no pre-built binaries for Tiger on the
> Git home page. I downloaded the source file from home page and issued
> the following commands:

Hi,

I just followed your exact instructions (even using the same prefix in 
configure) and ran the whole test-suite (and after that the offending 
test t2004 by itself again). It worked without a flaw here, though that 
probably does not help you much.

I too am using Mac OS 10.4.11 with GCC 4.0.1. Just wanted to let you 
know.

Regards,
Jojo

-- 
git version 1.5.6.12.g73f03
