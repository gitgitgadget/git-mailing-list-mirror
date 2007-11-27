From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 03:15:55 +0100
Message-ID: <200711270315.56849.jnareb@gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <7vd4twe9mn.fsf@gitster.siamese.dyndns.org> <20071127015942.GM14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 03:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwq0O-00051o-0t
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 03:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbXK0CQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 21:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbXK0CQI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 21:16:08 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:15235 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbXK0CQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 21:16:05 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1053557mue
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 18:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=i9BBD973z9rSLFVhOzbLRG+EtOmBgsgTnQyNcdzlMVM=;
        b=rN+LnZThn6S2rSfV5rc7Di9KDWfetaRUF1r9hD0WyIhV6kuVuH65ObRiSZqFg4UoWiD16hfnyXMgD+HVunOcH67pw29XxrVVgDTM8efwXtxBvcDXbjn/jSwnmaGjtB6bFruqgQwVGuttHzXY37eMHHSf3WBM7P9Rq5oTnPaYaRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bd6WcPF3p2WSlUvuAeAIAljdtBW62AyErckBXnI7P5XdTm/sWUeCOVfLKecBSlmZNmXSNYsF+sVkM5HpHmVtlYZNPB72WX3K3inObx59DAd+qpX8BBtR3rqb/H0HKu4VKXZ0pJWXIwn5tFwDRGteyD8Tqw+ggXOKDrY/UExu7fg=
Received: by 10.82.183.19 with SMTP id g19mr9120293buf.1196129763194;
        Mon, 26 Nov 2007 18:16:03 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.183])
        by mx.google.com with ESMTPS id g8sm5304545muf.2007.11.26.18.16.01
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Nov 2007 18:16:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071127015942.GM14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66162>

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>>
>> ... not to mention countless others you would get wrong that you did not
>> list in the above, as the current git got them right ;-)
> 
> Indeed.
> 
> Which is why nobody is looking to rewrite Git from scratch.
> 
> Except myself and a few other nuts who want a pure Java
> implementation for Eclipse plugins.  :-)

And the project to implement git in C# / Mono (I wonder what is
the status of those implementations...)

-- 
Jakub Narebski
Poland
