From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 11:10:29 +0200
Message-ID: <4A8E6485.7040006@gnu.org>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 11:11:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeQ9R-0003Uv-PC
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbZHUJKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 05:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbZHUJKc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:10:32 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:46092 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbZHUJKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 05:10:31 -0400
Received: by fxm17 with SMTP id 17so356838fxm.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Q13sgFpIczaweriEU2iMIB0IYiGyOTlyWiy53M8M8B8=;
        b=lRXt8Qzws3mD+yBaq/CLNtEQGeZSSXWFrDx1++lQrPd1B7byXWkRP96PFyy7nNBvAD
         APszC83PB17AXvB2NP2FARfgVOb90hZxmihipwnvxHZhGiJmJ9+Ny7kKi9aXzG64eBjs
         MHg47G3YOvMmbn3Ld9oxz7x4TRvCaD7sZ+56o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tii4X8MKbS6ZEFp8/TgzyFjjLyqcrlaxFqtN+p2lIVUNO7Op80MlnVXM4sf1gegUch
         1RAC61WT0YvZrNnhs3EezUjwclfMiua3qIKEVnmg54LNSvHPOBaFM0pEd3oeaV5yuwl3
         1WCYSUp6kd3zRghkKBJzE41BZkhenF3EIoreA=
Received: by 10.86.13.37 with SMTP id 37mr672294fgm.58.1250845831711;
        Fri, 21 Aug 2009 02:10:31 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id d4sm1248609fga.15.2009.08.21.02.10.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 02:10:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <7veir5naq3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126698>

On 08/21/2009 04:48 AM, Junio C Hamano wrote:
> Has been ejected from 'pu' for some time, expecting a reroll.

I've been trying for a while to have push refspecs and tracking working 
together, but haven't come with anything that I like.

I'll let it sleep for a while so that I can look at the problem again 
with a fresh mind when I come back to it.

Paolo
