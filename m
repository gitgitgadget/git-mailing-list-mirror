From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 00:16:09 +0300
Message-ID: <4A09E719.4090205@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302> <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com> <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 23:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3zKw-00015M-3w
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbZELVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 17:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbZELVQS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 17:16:18 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35090 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbZELVQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 17:16:17 -0400
Received: by ewy24 with SMTP id 24so326291ewy.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gDiuToFRQQWTmJFzjccUrmJGkYYjP1xsHRrar61GetA=;
        b=S3NRZTzt6OZnNjTd5LQjPb3MpoyWUexLGnXqbPVGJ310Bsfs+t67ybxbyRExBFVG5m
         9NzqY15q0ENnkiEy4kJLJIMT5Pl5yE8Vj8Hd847v72m4XyLcg/ObjUHrQ6Or3rehaeSS
         wh8WswltP9PJsUGoUhLSopuuH8+z2eo6Ew5ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cxtB2pdJZrjquw+9WqNJnavaZmdCgfiWMyMP5qWS2gbtoHzFnJt6QW4CugX0CePjS2
         +1XhdKdoESknHAQy6DBVrelJL9t4KbARkweGSEOMtAMLMbs4iYv1g9kPRjpXSybHJ6JZ
         Y3T9BSGy0EHqeq57MJIqYAI3gb33clDu1uHZs=
Received: by 10.210.56.7 with SMTP id e7mr211343eba.24.1242162977843;
        Tue, 12 May 2009 14:16:17 -0700 (PDT)
Received: from ?10.0.0.2? (dsl-hkibrasgw2-ff75c300-100.dhcp.inet.fi [88.195.117.100])
        by mx.google.com with ESMTPS id 28sm1104672eyg.14.2009.05.12.14.16.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 14:16:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118955>

Johannes Schindelin wrote on 12.5.2009 23:38:
> That is a nice analysis.  How about implementing it?
> 

Do we have here somebody, who knows Git's code well and is motivated to 
implement this?

I don't think that I would be capable, because of not having used C 
much, being new to Git's codebase and having too little time. But I can 
help with the requirements specification, interaction design and system 
testing.

-- 
Esko Luontola
www.orfjackal.net
