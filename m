From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Thu, 8 Dec 2011 11:00:27 +0530
Message-ID: <4EE04B73.8080102@st.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com> <4EE04A6D.5020503@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Vipin KUMAR <vipin.kumar@st.com>,
	Vijay Lakshminarayanan <laksvij@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 06:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYWZ8-0005mN-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 06:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781Ab1LHFah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 00:30:37 -0500
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:53008 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721Ab1LHFag (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 00:30:36 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob104.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTuBLeP98oFuI7MobBmH/0l0f5YVvBVBB@postini.com; Thu, 08 Dec 2011 05:30:36 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B4479E;
	Thu,  8 Dec 2011 05:22:03 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 58767F53;
	Thu,  8 Dec 2011 05:30:29 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Thu, 8 Dec 2011
 13:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <4EE04A6D.5020503@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186534>

On 12/8/2011 10:56 AM, Viresh Kumar wrote:
> For autosquash to work, we need to keep the same commit log/title,
> prefixed with squash! or Fixup! etc. What about adding another option
> in commit amend which adds squash! or Fixup! automatically. So, manual
> intervention at all. :)

Done. It is already there in git commit.

-- 
viresh
