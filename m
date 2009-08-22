From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to do "git merge --abort"
Date: Sat, 22 Aug 2009 09:56:49 +0800
Message-ID: <20090822015649.GC3965@debian.b2j>
References: <20090821145157.GA6471@debian.b2j>
 <20090821151926.GE6850@coredump.intra.peff.net>
 <200908211726.21593.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 03:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mefs5-0004aD-Je
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 03:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbZHVB44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 21:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933070AbZHVB4z
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 21:56:55 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39220 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974AbZHVB4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 21:56:55 -0400
Received: by pzk32 with SMTP id 32so183729pzk.33
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=VPinjy0A0q0KMI6bTFR+GGLOddo86jrsXXhX6COFzOA=;
        b=BAIk2bw+DeiCq233RAgcL4RqbAfQsBgz7nMEmtFsiIjresrijTqlYXhNXlAIqVsQ2x
         qQfBIZjGuhDdLt6o4l74FBnpTzTfwxN3QHfgnJP2riv2q4EaZPLQNzJ7mybNxn+IGJK2
         UZ6LVrw73ttxv1pIriaPo2AfcreKA77K/4FZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=CgHLCZ42lq7clrdjlx3Gxs1SNXIiKv6whZzdIESZoWan8O31Oh/2Htdn+K7PEacX6H
         +NNVQ0Dz3W1jPPCK04jdNWjdyTn+voC1YG3N68Oni8jrQAo7fE5UgkISl8KWwh6l67tY
         mt/YjUkqFAKyiAvJOvQ3DcY/e2iU+q/Ld5BqU=
Received: by 10.114.49.18 with SMTP id w18mr1801072waw.89.1250906215524;
        Fri, 21 Aug 2009 18:56:55 -0700 (PDT)
Received: from localhost (n219079101006.netvigator.com [219.79.101.6])
        by mx.google.com with ESMTPS id m28sm2847635waf.2.2009.08.21.18.56.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 18:56:54 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200908211726.21593.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126777>

Thanks to both of you. I'll try it when the next merge conflicts.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
