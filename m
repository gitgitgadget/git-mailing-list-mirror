From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: Re: User Authentication ?
Date: Mon, 13 Oct 2008 10:09:35 +0200
Message-ID: <912ec82a0810130109k56e2e976kd00678e2ca3bc558@mail.gmail.com>
References: <912ec82a0810110941t33343fe1mfe1bce58739f79fa@mail.gmail.com>
	 <m3y70vj8ag.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 10:10:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIVt-0001kM-2Z
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYJMIJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbYJMIJg
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:09:36 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:48458 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbYJMIJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:09:36 -0400
Received: by ag-out-0708.google.com with SMTP id 31so1819578agc.10
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HSm50W16tqygHd8eB5RbZTbDigDSuBRHcoYXchZjZ+A=;
        b=pDr8uGarUMiJSog5gaoUQeaL9Dse2WHkKi7iP1KOOx+6jLmcTSxlbdd7VuytiKua6l
         L4xri17csPzp7VYHar+Fuy9UALY+aVCowoIkI77rbZ8KHnnHSvHwSwVu2l2DwwC4x8ty
         9jVvfT8mHfEW6VFA8+iUpshJy+7pTCV8pI+qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nlnaBimuq6j91WKmoh4OkVAMy1+HV5LvXcqF6K8gTlkkw85UVYBKEWVFFbKNWY/7xn
         x+iu/Pjp3XTNTzMOZM3LtvSEAsjYXt7Wa9BLrKNHFmFTLaTxaBqvwXrSkNGp/y7qpX14
         qoQ192n9u9HAWqv19xhUWdi5RD73TXOJ81KFU=
Received: by 10.100.92.9 with SMTP id p9mr4816722anb.102.1223885375117;
        Mon, 13 Oct 2008 01:09:35 -0700 (PDT)
Received: by 10.100.93.12 with HTTP; Mon, 13 Oct 2008 01:09:35 -0700 (PDT)
In-Reply-To: <m3y70vj8ag.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98088>

Hi,

On Sat, Oct 11, 2008 at 8:28 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Neshama Parhoti" <pneshama@gmail.com> writes:
>
>> I want to setup a git server on the web but I need user
>> authentication.
>> I really don't want to give ssh logins for people who I just want to
>> be able to access my repository...
>
> First, you can always set git-shell as shell for those git only
> accounts.

Thank you ! That should really be good. Any chance you are aware of
documentation
or further guidance about how to set this up ?
thanks!
