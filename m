From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Fri, 31 Jul 2009 02:49:02 +0200
Message-ID: <20090731004902.GA19369@Pilar.aei.mpg.de>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com> <20090730145044.GA1727@vespa.holoscopio.com> <4A71C6A7.80008@drmicha.warpmail.net> <7viqhaar7v.fsf@alter.siamese.dyndns.org> <b8bf37780907301551w4cdc7e96m137aa188ce1a0a8c@mail.gmail.com> <20090730231911.GI1727@vespa.holoscopio.com> <7vtz0t7mnw.fsf@alter.siamese.dyndns.org> <20090731000808.GO1727@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 02:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWgKM-0002Cc-5R
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 02:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZGaAuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZGaAuV
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 20:50:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:64653 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZGaAuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 20:50:21 -0400
Received: by ewy10 with SMTP id 10so1191505ewy.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bH1ct5JtiCmfQwan2qLbiCCfvmJgbvSBihvLjmTkY98=;
        b=miMj3uAckke4nTC8MkEfiFTtjjyXeej7YV0TqmMDfm0oMg8ypAJJ2OzOlfhGe4vtn/
         lOf0NYx44renUe9j0iGpSjGXz6bw06SphG04Z7wxLlbbIaZmbp4FlJZ6MZLxrzj/6260
         sgvTZ2J66KlsJyjqI4btSnTxO6NHvZzHv/V70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mwMfg88RcA1WzRpgcVGluJuELo2thENUAF2mlVYaXj8mhc/93i+T098ioNGRoovKry
         Uct6M2YXpLANe591DW1kYnn/E7iGDbiyOHD9yQwqsSWy0DZ8RvyKmUznKry9CpWT+T7t
         vOJN+BQ8HZE058k9jD6wvrty7ckTpfP6+3Ku8=
Received: by 10.210.87.11 with SMTP id k11mr22675ebb.74.1249001420261;
        Thu, 30 Jul 2009 17:50:20 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.106.11])
        by mx.google.com with ESMTPS id 5sm1666983eyf.48.2009.07.30.17.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 17:50:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090731000808.GO1727@vespa.holoscopio.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124496>

On Thu 30.Jul'09 at 21:08:09 -0300, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Jul 30, 2009 at 04:53:39PM -0700, Junio C Hamano wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:
> > 
> > > I'd rather remove the linux example and use something else (like git
> > > itself), since the Documentation is not about linux, as Juno says and
> > > that would stop the disagreements.
> > 
> > That is unacceptable, _if_ you are adding a _translated_ version of our
> > primary documentation.
> 
> I can't agree more. In that view, would you agree to remove any mention
> to linux in the primary version?

I think you are being unreasonable.

Most brazilians say "o kernel do linux". That is a fact which you can't
change, and suggesting to rewrite the original documentation to 
avoid this issue which _you_ created is really making it sound
like religion. 
