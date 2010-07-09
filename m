From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] war on echo in scripts
Date: Thu, 8 Jul 2010 22:47:39 -0500
Message-ID: <AANLkTimt16IbvGii3tP4LisxIALuUQM6BPemmCRjvYrN@mail.gmail.com>
References: <20100706225522.GA31048@genesis.frugalware.org> 
	<7vpqyz278o.fsf@alter.siamese.dyndns.org> <20100707091633.GB31048@genesis.frugalware.org> 
	<AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com> 
	<20100707094620.GC31048@genesis.frugalware.org> <7v7hl6stna.fsf@alter.siamese.dyndns.org> 
	<20100708103552.GF31048@genesis.frugalware.org> <20100708171418.GA18229@burratino> 
	<m2k4p58tum.fsf@igel.home> <20100709024633.GA13739@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX4ZO-0007QL-Q6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab0GIDsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 23:48:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64204 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab0GIDsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 23:48:04 -0400
Received: by yxk8 with SMTP id 8so323651yxk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qDmhXjH3esGkfcdnQMPz9PthW6Z2q70rbbHNHISy6mw=;
        b=BY7xKLio6E507CKpzOIDvY2si2LGA5ypGTnJ/gpZCknPy/S2jLxVxX2qVRSK+fJuZY
         xT5fBJfUNijsXU1yL1Hh98H8eMIqMVja7GFQ9KVToK2ETmnVMNgakm7dkEXoNgDgZ3u0
         kGpniqI+gAJOGqF4c5DcYCWyuN5v9GoA6vA0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XQx7IUW17fI0JyvPAGDrpCu0ZvbTDP/wE8WWjGPanmZQqTZQZ+0IPsWSyaNIynP5tT
         U1tIHT6+g6YxK3rxUcYIJcgFrIiuEFjmy2baSzXSj70Zjc917vRkwY+EiXLOv4J9ACN/
         JZE/4nnSGUYJPlyNA1txFNSytjxt9AUDEEevU=
Received: by 10.150.173.35 with SMTP id v35mr1293450ybe.251.1278647279314; 
	Thu, 08 Jul 2010 20:47:59 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Thu, 8 Jul 2010 20:47:39 -0700 (PDT)
In-Reply-To: <20100709024633.GA13739@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150639>

Heya,

On Thu, Jul 8, 2010 at 21:46, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hmm, maybe something like this would be easier.

You mean instead of the fairly huge patch you sent earlier? Sounds
like a good deal to me ;).

-- 
Cheers,

Sverre Rabbelier
