From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Tue, 02 Apr 2013 21:56:19 +0200
Message-ID: <515B37E3.6030706@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com> <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com> <20130331225747.GB11704@elie.Belkin> <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:58:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7LF-0001J6-44
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111Ab3DBT5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:57:32 -0400
Received: from mout.web.de ([212.227.15.3]:61063 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700Ab3DBT5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:57:32 -0400
Received: from [192.168.178.41] ([91.3.136.234]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M73o5-1UbK9W1KZJ-00wUIj; Tue, 02 Apr 2013 21:56:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Eq5Qy4/wP/oTxaH7N3kp7XZ8LLjiRHiuJxZk4kYw+Nm
 +nZDWlRg5P5aYvVmgY3xHl+QwLIQZPsmxo6o02LgPHUCrq7T5U
 /wEVGMb3J8mIeVCTHvUj6bOWrx6qYukAWU028HOFndU+3d3yoy
 8TuFU4G9Df52CX5leuqzKI5jPoc7/7VNbF85g/HxVlmLhclcs6
 eKl9WFnsscrZjq4iSicrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219871>

Am 02.04.2013 19:44, schrieb Ramkumar Ramachandra:
> Jonathan Nieder wrote:
>> Elated is probably not the right word.  More "annoyed at being told
>> their work is ugly without an accompanying concrete and actionable bug
>> report". :)
> 
> If I had an actionable report, I'd have started hammering patches
> instead of wasting everyone's time here.  I'm was presenting fragments
> of my thoughts, hoping that it turn into concrete actionable work
> after exchanging a few emails.  I'm also annoyed that it didn't
> happen.

But didn't we already note three worthwhile patches (get rid of the
top-level requirement and relocate a .git directory at "add" time
and anytime later)?
