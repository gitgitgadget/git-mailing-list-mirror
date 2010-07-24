From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] t/README: A new section about test coverage
Date: Sat, 24 Jul 2010 16:29:07 -0500
Message-ID: <20100724212907.GA5664@burratino>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
 <1280004663-4887-7-git-send-email-avarab@gmail.com>
 <20100724212542.GA5610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 23:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcmIU-0004Sh-Dk
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 23:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab0GXVaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 17:30:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39214 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0GXVaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 17:30:12 -0400
Received: by yxg6 with SMTP id 6so1572200yxg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ddTEcZ3AflXUyugjW4iKTi2h+HMe5k4swKwt7vmZCSI=;
        b=T4iqepyeBlfY1X0WmbqcoH6YVEvX5VyoCfAEAbpgGGd270npcLpi98WynatMAuHN0q
         fr0uPr40KKncitJAhSVGex5x/EHFiFLp01F0U8EFcu57jAquZCQsI2Rm/4x/a0xJv/zC
         KL7LgklMnyDqjbOV1R+T7ZxhZqydsb0bYwuHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oNJka4Rnp9d0F5rZR+Zu1BXH1dP5kpWllPwzgG+KGv/Tug6BFHFuPdg6gk4S0C2zqM
         d5/V+FIzLzCQJ4L44Ao2BXmwIrcQcY03plmIHpbzjG2zVUWtAbF0l12N1F0OjOc6oV8w
         9rdRubYwNDvFyUB3ojHAySp8bdgKjZ5pwntYE=
Received: by 10.101.139.2 with SMTP id r2mr5478686ann.16.1280007011237;
        Sat, 24 Jul 2010 14:30:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f22sm3020147anh.4.2010.07.24.14.30.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 14:30:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724212542.GA5610@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151677>

Jonathan Nieder wrote:

> 	You can use the coverage tests to find code paths that are not being
> 	properly exercised yet. To do that...

er, that should have read "used or properly exercised" rather than
"properly exercised yet".

Sorry for the noise.
Jonathan
