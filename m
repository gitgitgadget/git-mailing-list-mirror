From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Maintaining historical outlines
Date: Tue, 03 Apr 2012 21:45:11 +0200
Message-ID: <4F7B5347.3010701@web.de>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com> <201203301510.q2UFAqn6003864@no.baka.org> <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:47:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF9hO-0005OU-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 21:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab2DCTrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 15:47:22 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:37391 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2DCTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 15:47:21 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate07.web.de (Postfix) with ESMTP id 7E9DDFFF978
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 21:45:15 +0200 (CEST)
Received: from Sonne.site ([78.48.1.206]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LhNWS-1SbJDH0jjM-00mZwx; Tue, 03 Apr 2012 21:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120328 Thunderbird/11.0.1
In-Reply-To: <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
X-Provags-ID: V02:K0:vr2ld9Vtk4AHMDuMdzJ/JA1nQ4JAT69vCSWZRau6GLI
 03m7IaJ8rLRoQedlQOyK7YQ2dz2+mi2RAxxJ9SoNF0fAlemEFH
 xX+EjV73Ey7agBuzBQeoKNWfghdT1mVu+JgrsCs2aONMvVM7Y0
 xN58mWMU0+y7oddrytnjyMldIAapE7Xpk3c+w7dEPBWZq8TuxF
 bW0Ui16vbjTXgn7p6yVhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194641>

> Our use case for this is like so:
> "ok, this is how the law is today, and we're not quite sure how it got
> to this point"
> But then some X time later:
> "so we found out that clauses (1), (e) and (X) were changed on March
> 30, 1957, and we want to know this for future reference"

I imagine that technical challenges come from a different view for your use 
case. Content management systems can eventually show differences for 
line-oriented text files easily. But I guess that you are also interested in the 
maintenance of higher level semantic data structures that are usually contained 
in outlines.

How would you like to build relationships between commit logs and changes to 
items like chapters, sections, paragraphs and sentences?

Do you need to combine several information sources to generate a document query 
and result representation you desire?

Regards,
Markus
