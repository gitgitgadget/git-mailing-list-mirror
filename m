From: Michael Bergin <michaeljbergin@gmail.com>
Subject: Re: Git Option/Subcommand Processing Library?
Date: Sat, 25 Jul 2009 20:38:48 -0400
Message-ID: <D48B952D-501B-4B90-A2B7-00DF5F21D3A4@gmail.com>
References: <231BD892-07B1-452C-A224-047829E21991@gmail.com> <alpine.DEB.1.00.0907251830420.8306@pacific.mpi-cbg.de> <D30CE3A7-176D-4132-88A6-23C46A4EA185@gmail.com> <alpine.DEB.1.00.0907260117540.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 02:39:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUrlk-0004Pn-KG
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 02:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZGZAi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 20:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbZGZAi6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 20:38:58 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:36603 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZGZAi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 20:38:58 -0400
Received: by qyk34 with SMTP id 34so1190382qyk.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=7InTpNlkw47ZC5AfMlxvuTAnzi3YRd4xPF62Z6Uag9I=;
        b=PdjsgxxAhqL27uifzTV7/TEuUcb0B3Wk3Yz97n/GwNR4YdgSH6KE04icc5OqYOfsky
         PKChq13YJnZYCzAdgq47LRWnSUtjpMnlUW8lcvBjrs1SetOoJ1PJ9Cvkwhl24uTOysrZ
         fTJG6XcDHApfOD53Zx9MVPcWGBJ5P7v9HTilE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=JgZbnytPa2H06lOb5W8un0KdXZBtl2X54b9T1QXc5R+fFOOQHSFJttvxCY1JpxTwcc
         D9djhZhxvKjHl22EKoIiEmd8LPsoDUCeEziUNXOTI7nnDPN4zrszfty85ZWpRGu5RlnC
         oX68P+8sP+vqP8b1TePPnGJA0/BOZ88xZUAT8=
Received: by 10.224.37.66 with SMTP id w2mr4720027qad.333.1248568738010;
        Sat, 25 Jul 2009 17:38:58 -0700 (PDT)
Received: from ?166.203.127.199? ([166.203.127.199])
        by mx.google.com with ESMTPS id 26sm13203qwa.39.2009.07.25.17.38.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 17:38:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907260117540.8306@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124101>

I really appreciate your help.  I'm going to do this regardless of  
license so I'll ask about that when I have a finished project.  Let me  
know if you have any suggestions for features, etc.  Thanks again.

- Mike Bergin

On Jul 25, 2009, at 7:18 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 25 Jul 2009, Michael Bergin wrote:
>
>> Thanks for the pointers.  I also want to create a generic library for
>> command facades like git.  For that I will probably use git.c as a  
>> guide
>> but to make it generic I would need to add/rearrange code.  GPLv2  
>> works
>> fine for my purposes.  I hope this isn't an offensive question or
>> anything but would releasing just the library under LGPL be  
>> considered?
>
> You need to ask all authors of all the code you reuse.  I, for one,  
> have
> no objections.
>
> Ciao,
> Dscho
