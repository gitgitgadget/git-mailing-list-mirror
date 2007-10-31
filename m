From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: cogito and remote#branch, was Re: [PATCH] Git homepage: remove all the references to Cogito
Date: Wed, 31 Oct 2007 22:17:10 +0100
Message-ID: <2c6b72b30710311417i255df44eue7eb9d63ea9fcd9@mail.gmail.com>
References: <20071015233800.6306e414@paolo-desktop>
	 <20071016021933.GH12156@machine.or.cz>
	 <Pine.LNX.4.64.0710161139530.25221@racer.site>
	 <2c6b72b30710161516j5c029847r1acb3ce2d88344a1@mail.gmail.com>
	 <20071031170951.GR18279@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKxT-0003J0-Oz
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760856AbXJaVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760851AbXJaVRM
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:17:12 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:50005 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760517AbXJaVRL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:17:11 -0400
Received: by rv-out-0910.google.com with SMTP id k20so256283rvb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nWx5DVGQPw3uYbAigz0dt4c3pPhPhewpFYN/G/JLz5U=;
        b=noPdhB88wmFTlGENlnKe8dAgJDGAeXH29urmf0lHP/uYa/Hbb98QuUki24Yk5piLKSEwyQu40gn8vYccj+xIYbLsBQs0VcAEp8ZLoqqPJGyPs6Lja88YiydEFkGBC4n0koQKSQGK1bUWB8kLE64I5KdkdP+nG7L8Dg8eaT7yDk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c0c+dQd9uW4lU8eeW+AV4K7kwJgtD2r58XbdDLOD56SD7pRisfFoCk5QVPCNC6efdzoupc6p+vvwXa773PhuMpdCgKQFqhn8pp+YUuFE0kN6KAS4K8yzNqavjEXEQFCEVBh0s2T/PvMV1G1YPCZhKEbGNr2RHV8WpuQy2JqFlCk=
Received: by 10.141.37.8 with SMTP id p8mr4202742rvj.1193865430970;
        Wed, 31 Oct 2007 14:17:10 -0700 (PDT)
Received: by 10.141.5.5 with HTTP; Wed, 31 Oct 2007 14:17:10 -0700 (PDT)
In-Reply-To: <20071031170951.GR18279@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62873>

On Oct 31, 2007 6:09 PM, Petr Baudis <pasky@suse.cz> wrote:
> And some command in Git to easily get the equivalent of cg-status -g
> output is something I probably miss the most in Git now. (Originally I
> was about to say that I just miss an equivalent of cg-status, but
> thinking about it, most of the time I'm interested only in either -g
> (long branch info) or -w (git status output)).

Try `git branch -v` ... maybe with an added -a.

-- 
Jonas Fonseca
