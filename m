From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to determine oldest supported version of git
Date: Wed, 15 Feb 2012 12:44:08 -0600
Message-ID: <20120215184408.GA23119@burratino>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
 <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
 <20120215053607.GC29902@sigill.intra.peff.net>
 <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
 <20120215183454.GA23016@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxjqA-0002dN-1E
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab2BOSoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 13:44:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52704 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2BOSoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 13:44:25 -0500
Received: by iacb35 with SMTP id b35so1788298iac.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e3AypHtLqNlYioA0U5hWe6C68EOlzWbL0y/m+/pxgFg=;
        b=HS+uj3k7VkVxFQAb32sT9Ngfkwq27qgITIvrWyYMgGaoO2IlHdwX4hcKFK7SEcL742
         AGqoTGVMNheicEzZvaXSLBjNn+bmeA4pSpCWuwvrUPIFhV5iLKgW4ASuNAWOMl+VNl9M
         qc3eVPYRqE89jm8dbQfNV+hvExHmSAKIl1Su4=
Received: by 10.50.156.196 with SMTP id wg4mr44018787igb.13.1329331464900;
        Wed, 15 Feb 2012 10:44:24 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ko6sm26213346igc.2.2012.02.15.10.44.23
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 10:44:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120215183454.GA23016@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190848>

Jonathan Nieder wrote:

> Even with this, the extra time to migrate from 1.7.6 to 1.7.7, for
> example, was very helpful in the context of Debian sid.

Whoops, off by one error.  The extra time to move from 1.7.4 to 1.7.5
and 1.7.5 to 1.7.6 was helpful.  1.7.7 was actually pretty painless,
so sid moved to it right away. ;-)
