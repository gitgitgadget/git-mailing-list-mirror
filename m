From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [cogito-0.18.2] Documentation/Code Mismatch: cg-switch -l
Date: Tue, 27 May 2008 10:11:27 +0200
Message-ID: <998860CC-E94E-4C61-964A-0CB9F44074C1@wincent.com>
References: <20080527080417.GA32209@lifebook.rekudos.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Lawrence <nomad@null.net>
X-From: git-owner@vger.kernel.org Tue May 27 10:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0uJE-0003qA-F9
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYE0IMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 04:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYE0IMU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:12:20 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:54073 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbYE0IMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 04:12:19 -0400
Received: from cuzco.lan (156.pool85-53-26.dynamic.orange.es [85.53.26.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4R8BRM4013625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 27 May 2008 04:11:29 -0400
In-Reply-To: <20080527080417.GA32209@lifebook.rekudos.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82987>

El 27/5/2008, a las 10:04, Mark Lawrence escribi=F3:
>> On Mon May 26, 2008 at 02:19:04PM +0200, Andreas Ericsson wrote:
>>> Mark Lawrence wrote:
>>>> Hi,
>>>>
>>>> I don't know if this is a bug or just my understanding, but I'm =20
>>>> having
>>>> trouble matching the behaviour of "cg-switch -l" with the =20
>>>> documentation.
>>>>
>>>
>>> Cogito became officially unmaintained a very long time ago (late =20
>>> 2006?)
>>> and will almost certainly not work properly with any half-recent =20
>>> version
>>> of git. Don't use it.
>>
>> Oh. That's only <sarcasm>slightly annoying</sarcasm> to learn now, =20
>> given
>> that I've spent the past two years learning and converting my =20
>> projects
>> over to cogito :/ Could somebody *please* update the cogito web =20
>> page at
>> http://git.or.cz/cogito/ and put a big (maybe even blinking) notice
>> informing people of this?
>>
>> Bit of a shame that it's died though, because I appreciated the =20
>> simpler
>> interface (and some of the output I find nicer).
>>
>> On a more practical note, am I likely to suffer any issues using pur=
e
>> git on repos created with cogito?
>
> And a related question: is there any kind of cogito replacement that
> provides a simplified interface? As far as versioning tools go, git i=
s
> quite low-level...

The reason why cogito fell out of maintenance is that git itself has =20
evolved from the hard-core, close-to-the-metal tool that it was in the =
=20
early days to be usable by mere mortals. What specific features/=20
workflows of cogito are you missing? It's likely that modern git =20
already has an equivalent that is just as easy to use.

Wincent
