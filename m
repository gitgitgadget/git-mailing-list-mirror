From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support of "make -s": do not output anything of the build itself
Date: Wed, 7 Mar 2007 00:56:30 +0100
Message-ID: <81b0412b0703061556o2b648b58kaf1116ba29485d3@mail.gmail.com>
References: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
	 <20070306232927.GB25785@spearce.org>
	 <81b0412b0703061533o532dfeedo1aeb65723717227a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjWJ-0002Ch-4L
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbXCFX4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbXCFX4d
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:56:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:31187 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030711AbXCFX4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:56:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2670027nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:56:31 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bf56PPN94uwGHfHfgU0IaD2WSlMKVi5/N4Z1M92Qs98ffVe+uv4JHc00VvnygxRQXXyMEdvyZv8mfdnUw6O7s5CiNCka8HhkZO9fp00A28RheQJoWW4tsqBHvTe4JzB08/I0DsmiP3I1DSYp57f59nrNbmypB/pgDhuBMgD7QYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sD8/oann4uOhCjldFguZINNjWnJ0ODafP2RWbFq0z4qy0gx+l02aXaus4RJWLRHBRdiEYvz5n5ULSRCfaneJQD6JFJzB0iF46zMqmg6heHxF6F1ZXCm/l6KGj8WKhoWICUJRYtZ5B5C34P0dnkzAcLBvLkejgwPhHCqjiUdJbLk=
Received: by 10.78.180.18 with SMTP id c18mr874946huf.1173225390875;
        Tue, 06 Mar 2007 15:56:30 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:56:30 -0800 (PST)
In-Reply-To: <81b0412b0703061533o532dfeedo1aeb65723717227a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41621>

On 3/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> P.S. I'm glad that someone can here me from here :)
>

"Hear", of course. And it does not seem to work really...
