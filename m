From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 20:46:22 +0200
Message-ID: <200610202046.23202.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <200610202035.26227.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazO9-0002RV-8v
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992692AbWJTSqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992704AbWJTSqW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:46:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:27951 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992702AbWJTSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 14:46:19 -0400
Received: by ug-out-1314.google.com with SMTP id z34so705428ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 11:46:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kH5p42LadbToMRiAXNs/g9OasEs11K41BTneGToNgGJt6ry2KXWjbB/cxq5zFrvn0fuXFJL80zzFVHcd9bWEGAPidOdDEcrLYieJZEYcQSiVXzB+9pcZJHUBF1RWbfEoEgpWjcBGRxxiC3ssqTbWNSJMeSx9dyclj2W7xKxFVRw=
Received: by 10.66.249.11 with SMTP id w11mr2013574ugh;
        Fri, 20 Oct 2006 11:46:18 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 72sm1596826ugb.2006.10.20.11.46.17;
        Fri, 20 Oct 2006 11:46:18 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <200610202035.26227.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29520>

Jakub Narebski wrote:
>> A$ VCT commit -m "Moved hello.txt to data dir"
> 1092:jnareb@roke:/tmp/jnareb/tmp> git commit -a -m "Moved hello.txt to data dir"
> 
>> B$ ed hello.txt
>> ? 1s/Warld/World/
>> ? wq
Sorry, I have forgot to put in email "git checkout B"
to actually switch to branch B.

> 1094:jnareb@roke:/tmp/jnareb/tmp> ed hello.txt 
> 13
> 1s/Warld/World/
> wq
> 13

-- 
Jakub Narebski
Poland
