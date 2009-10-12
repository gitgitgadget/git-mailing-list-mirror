From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 20:30:52 +0200
Message-ID: <81b0412b0910121130l488ab4beycc405ceafa7d6260@mail.gmail.com>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	 <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
	 <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
	 <81b0412b0910121115s26c6c08s1ea54c28851faf05@mail.gmail.com>
	 <20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Noonan <steven@uplinklabs.net>, git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Mon Oct 12 20:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPlE-00010D-C2
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515AbZJLSba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbZJLSba
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:31:30 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59227 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414AbZJLSba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:31:30 -0400
Received: by bwz6 with SMTP id 6so3328534bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+g2mzEHIbvQh9Yz/KwTsCMCIrgb1vYzaWqpM4mkM8AM=;
        b=pzWJh4CiKw7tR2FkpqANS5XZZ76X7omkpp9k9Tep2UR+pR73/fqX6R5VdzRgPIxjxi
         /YrStxJ7RrDm+sHxTuE1pFpPrFXmEtnggQNL8XLpp50hyXD7qEAGnkbR3SerzBNhZxSY
         b9KishlB4JEJfswi4bJ1NxEAevj8gXo9/WbK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gx3M8HzcIaX/HMIZeW5J+4Y63Z5rznnajSPqZkQIXAYNd1sbWlROLz6uk/jGs1Da2u
         Xa+JXwqpHvLM4r9M/uCUlL72oMlSh2d1DMv7/hJqpnnx/hTxgmdjBFzMAK/bgBtW3MGW
         09yUn0r6absefg2KcRZWbbuHgfntPEM4NpiM4=
Received: by 10.204.24.75 with SMTP id u11mr5362567bkb.0.1255372252910; Mon, 
	12 Oct 2009 11:30:52 -0700 (PDT)
In-Reply-To: <20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130046>

On Mon, Oct 12, 2009 at 20:20,  <sylvain@demarque.qc.ca> wrote:
> Quoting Alex Riesen <raa.lkml@gmail.com>:
>> It's more of "a note to the future generation of developers": "Hey guys,
>> we didn't need that working, but if you have a night to spare could you
>> please finish that?"
>
> Ok, then I won't wait for it to work. I will dive in Git's code and play the
> "future generation of developers" part... some day. ;-)
>
> Thank you! :-)
>

Hmm... This strategy to encourage new contributors didn't quite worked out.
Must try something else next time. Do you like sweets? Just asking...
