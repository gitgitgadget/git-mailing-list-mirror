From: konglu@minatec.inpg.fr
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 12:13:35 +0200
Message-ID: <20120611121335.Horde.NUDqUXwdC4BP1cTP77JwT6A@webmail.minatec.grenoble-inp.fr>
References: <20120611073232.GA5602@richard>
 <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard>
 <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
 <20120611112516.Horde.jg0rcXwdC4BP1bl8bOMwLoA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSYYsNTxPRhL5LM_c-KcruAhzKmqvDTNzpS09ukpQ=sbvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se1d1-00027t-Df
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab2FKKNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 06:13:39 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:38391 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431Ab2FKKNi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 06:13:38 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 449FE1A025D;
	Mon, 11 Jun 2012 12:13:36 +0200 (CEST)
Received: from wifi-029112.grenet.fr (wifi-029112.grenet.fr
 [130.190.29.112]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 11 Jun 2012 12:13:35 +0200
In-Reply-To: <CABPQNSYYsNTxPRhL5LM_c-KcruAhzKmqvDTNzpS09ukpQ=sbvw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199639>


Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:

> I meant to switch to "sendmail", but keep "sendemail" around to be
> backwards compatible.

Sounds good to me. That would avoid everyone to change their config fil=
e
and, for those who haven't set [sendemail], it would be more natural to
type "sendmail" than "sendemail" (that's my personal opinion though).
