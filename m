From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Fix handling of remotes with single-character names
Date: Fri, 31 Jul 2015 17:01:58 +0200
Message-ID: <55BB8DE6.9030401@alum.mit.edu>
References: <cover.1438117334.git.mhagger@alum.mit.edu> <xmqq4mkl70st.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: =?windows-1252?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:02:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLBpJ-0005EZ-5S
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 17:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbbGaPCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 11:02:18 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63882 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369AbbGaPCO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2015 11:02:14 -0400
X-AuditID: 1207440f-f79df6d000007c0f-e6-55bb8de88088
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D7.4C.31759.8ED8BB55; Fri, 31 Jul 2015 11:02:00 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D52.dip0.t-ipconnect.de [79.201.125.82])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6VF1wYD021968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 31 Jul 2015 11:02:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqq4mkl70st.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqPuid3eowedZVhbzjy1mtui60s1k
	0dB7hdmB2WPnrLvsHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ2x7Ntq9oLHTBVPfzxka2Cc
	wtTFyMkhIWAicaXhKwuELSZx4d56ti5GLg4hgcuMEjsOvWCCcM4zSfxs2soMUsUroC1xY88T
	oA4ODhYBVYmT65RBwmwCuhKLepqZQMKiAkESr1/mQlQLSpyc+QRsvoiAmsTEtkNgNrNAvETv
	9gawicICPhKLTtxiBbGFBNIkdrxeyAZicwpYSzx8MB2qXk9ix/VfrBC2vETz1tnMExgFZiFZ
	MQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5ihAQu/w7GrvUy
	hxgFOBiVeHgFFu8KFWJNLCuuzD3EKMnBpCTKu6Bhd6gQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed72DqAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mC92w3UKNgUWp6
	akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KE7ji4GRCpLiAdor3AOyt7ggMRcoCtF6ilGX
	Y8GP22uZhFjy8vNSpcR5/4LsEAApyijNg1sBS1OvGMWBPhbmLQEZxQNMcXCTXgEtYQJa0te+
	A2RJSSJCSqqB0c6oPfTezk1u9VM/eJ9TuNroHqD+5Xjlr4Z1nkZRbGuWOU9eFeFrsG5DWwHP
	KpkpDc0fnZuaiwNrepI5Xr+ynz9vowLPwue2G66y9GpUKLX31l3f+usAQ71TUYar 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275050>

On 07/31/2015 12:12 AM, Junio C Hamano wrote:
> Thanks, queued.
> 
> By the way, do you plan to revisit two rather large-ish stalled
> topics of yours queued on 'pu' any time soon?

I hope to revive the "tempfile" and "numparse" topics earlyish in this
release cycle if at all possible.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
