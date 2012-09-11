From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: How to update a cloned git repository
Date: Tue, 11 Sep 2012 18:46:11 +0200
Message-ID: <007401cd903c$f425fc20$dc71f460$@schmitz-digital.de>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr> <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de> <vpqy5kgdctm.fsf@bauges.imag.fr> <007001cd9016$8f980f80$aec82e80$@schmitz-digital.de> <vpq4nn4d968.fsf@bauges.imag.fr> <7v1ui8k0in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTcM-0003ax-AC
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758517Ab2IKQrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:47:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758427Ab2IKQrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:47:09 -0400
Received: from DualCore (dsdf-4db532aa.pool.mediaWays.net [77.181.50.170])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LznVv-1TfV181VUx-014pni; Tue, 11 Sep 2012 18:46:18 +0200
In-Reply-To: <7v1ui8k0in.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKMBvoOU6gFyfWBzbsL0abxuS38eAGIfo3NAn/3ZEkBI0tT7gGZb1rsAnF9OYoB3Rh6tZWvzabw
Content-Language: de
X-Provags-ID: V02:K0:TNgiw+I5gLwfIjj+J9ZyJSqSf6GQRqv5u6xgIqx992g
 22mjUA1y2iiryDFhsQDeeLS73PI9s5z4fR8VLxAkroqzuJN+K4
 9/E/Rr+mj/RQ+0XZpaLNR+PchPWJ792+DmUUy3XXant5FWWeae
 UJmVhklmBEXnHnMrdVNIzAyozlvE2cDMqDwu7surUhLdIW/DWK
 hRNeCbNuBlT80aPiTAdgbLpPrSlNMHspsCxTK+urhKEwGd3uNe
 kyFaPgK6VxzhNgkQSIv7rrPUw7fSrUPpIaO7BzsMp82T5DhnNJ
 xcbeEsodDAqwMW1jXS+Qc4Ifn8jdrgeEBvn4z+6Ch4ecv/Btkk
 IgvbpUXa9bohL91KPeYj2e+tXxx8IhZgAKwRhHnEdWrb+YmwVK
 1KTlm5Jt0hKdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205249>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 11, 2012 6:06 PM
> To: Matthieu Moy
> Cc: Joachim Schmitz; git
> Subject: Re: How to update a cloned git repository
> 
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > [ Re-adding git@vger in Cc, I guess it was meant to be so ]
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> >>> Then, work on the tip of the topic branch you depend on instead of pu.
> >>> These are more stable, as they will be rewritten only if this particular
> >>> topic branch changes.
> >>
> >> These are not available from git hub. Or are they? How?
> >
> > I think they exist in some of the repos junio pushes to, but I don't
> > remember how/which one.
> >
> > Anyway, you can easily get it from the commit that merges the branch
> > (it's the-merge-commit^1).
> 
> I think it is the-merge-commit^2; contrib/git-resurrect.sh might be
> of interest, too.

Sorry you lost me, this is greek to me...
