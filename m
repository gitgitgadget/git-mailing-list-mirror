From: viresh kumar <viresh.kumar@st.com>
Subject: Re: git send-email doesn't take To: addresses from the patch
Date: Fri, 3 Sep 2010 09:32:03 +0530
Message-ID: <4C80733B.2020406@st.com>
References: <4C7B5853.7010001@st.com> <4C7E05B5.1050805@gmail.com> <4C7E1537.9030405@st.com> <AANLkTi=xQAoEFiB2zGz73ZwSwq16LOthkqd7w1GhnEup@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 06:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrNUC-0004W3-41
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 06:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab0ICECT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 00:02:19 -0400
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:39438 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab0ICECS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 00:02:18 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob101.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTIBzQ78BZwFEoFrulG40HRgXl82KLAav@postini.com; Fri, 03 Sep 2010 04:02:18 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 73815122;
	Fri,  3 Sep 2010 04:02:07 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5EBACBB6;
	Fri,  3 Sep 2010 04:02:07 +0000 (GMT)
Received: from [10.199.82.92] (10.199.82.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 3 Sep 2010
 12:02:06 +0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=xQAoEFiB2zGz73ZwSwq16LOthkqd7w1GhnEup@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155234>

On 9/3/2010 12:06 AM, Stephen Boyd wrote:
> Cool. Junio, does this look good to you? I can squash in some tests
> later tonight if I get some git time.

It works perfectly fine for me.

thanks
viresh
