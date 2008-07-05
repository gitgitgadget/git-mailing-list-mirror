From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: git sequencer prototype
Date: Sat, 5 Jul 2008 11:12:36 +0100
Message-ID: <18071eea0807050312m2f5a60ebyb86177f6b10f3a7e@mail.gmail.com>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
	 <20080704210052.GA6984@steel.home>
	 <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
	 <20080705081321.GA4935@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Stephan Beyer" <s-beyer@gmx.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <fork0@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jul 05 12:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF4lr-00025Q-Mb
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 12:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbYGEKMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 06:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYGEKMj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 06:12:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4087 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYGEKMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 06:12:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so883912ugf.16
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YkcMXD9d23pGIAXkFkcojukAJKA/NIyPPlWWCYP+yrw=;
        b=rThkI9eyYBzN6jeMLaCCHGfltOyZZrqF/Pp9ANsdLb6FSu6aix5nIV6sKnMvWfVPru
         y94rTEfvPCGpxaTcg0o+ZWPLXeUED3IY/TRv1NfZyY80vbxvJtlzRQ1/EYWJ87jrHnID
         PkGi3901yqlznlYb3MKZygF55P88stnT3raMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AxuPGC83McXOfb1e+dxz3YebK8iaSFG+gpk/DUa9BGzuQk5tfZkXflEXx7SSNnwY02
         uB0fvvOou0UU6d/7yI7oS5RzaQnIiizSRiuEDAEe9JFOyxxUFjfKR1mEy8QgBoQw9Q56
         70ORAKrp9okHm6rvzMxrV5b25B5Q9UpTufF1g=
Received: by 10.103.18.19 with SMTP id v19mr808851mui.113.1215252756521;
        Sat, 05 Jul 2008 03:12:36 -0700 (PDT)
Received: by 10.103.46.1 with HTTP; Sat, 5 Jul 2008 03:12:36 -0700 (PDT)
In-Reply-To: <20080705081321.GA4935@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87440>

2008/7/5 Alex Riesen <fork0@users.sourceforge.net>:
> BTW, what does "am" (git am) mean?

I always thought of it as "apply mbox".

-- Thomas Adam
