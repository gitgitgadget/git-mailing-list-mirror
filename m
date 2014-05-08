From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: Beginner question on "Pull is mostly evil"
Date: Wed, 07 May 2014 17:45:30 -0700
Message-ID: <1484962.u3Uah1apFn@thunderbird>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET> <0C723FEB5B4E5642B25B451BA57E2730751C2AB2@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 03:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiD5D-00063p-TR
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbaEHBZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:25:08 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:56823 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaEHBZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 21:25:07 -0400
X-Greylist: delayed 2556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2014 21:25:07 EDT
Received: from fed1rmimpo109 ([68.230.241.158]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20140508004229.XABF24376.fed1rmfepo103.cox.net@fed1rmimpo109>
          for <git@vger.kernel.org>; Wed, 7 May 2014 20:42:29 -0400
Received: from thunderbird ([68.231.74.114])
	by fed1rmimpo109 with cox
	id zCiV1n00K2TxN4s01CiViu; Wed, 07 May 2014 20:42:29 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020207.536AD2F5.00D3,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=JNPlRb2b c=1 sm=1
 a=So8zV0cAyE/J2U/+o1/Dyg==:17 a=HZTKFlc_eFYA:10 a=9WgkDmkfN58A:10
 a=G8Uczd0VNMoA:10 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=HFKujjh8AAAA:8
 a=VwQbUJbxAAAA:8 a=eC_hR14S0q_r25voJfcA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=BbY817XAw1EA:10 a=So8zV0cAyE/J2U/+o1/Dyg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 448E613F635;
	Wed,  7 May 2014 17:45:31 -0700 (MST)
User-Agent: KMail/4.13 (Linux/3.13.0-24-generic; KDE/4.13.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248398>

I'll create a patch.

On Wednesday, May 07, 2014 01:51:04 PM Junio C Hamano wrote:
> Jim Garrison <jim.garrison@nwea.org> writes:
> 
> >> -----Original Message-----
> >> From: Junio C Hamano
> >> Sent: Wednesday, May 07, 2014 1:16 PM
> >> Subject: Re: Beginner question on "Pull is mostly evil"
> >> 
> >> No.  This is most often true for people who use a single repository as a
> >> place for everybody to meet, in the same way as SVN.
> > [snip lots of excellent detail]
> >> HTH.
> >
> > Wow.  That helps tremendously, and should be incorporated somewhere in the
> > Git documentation.  Thank you for your immensely detailed response.
> 
> We used to collect useful list postings in Documentation/howto/;
> perhaps somebody wants to do the minimum copyediting of the message
> and send a patch?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
