From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 02:10:13 +0200
Message-ID: <200807240210.13955.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200807231508.42334.jnareb@gmail.com> <7vwsjcft5g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLoQY-0007hr-2O
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYGXAKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 20:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbYGXAKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:10:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45633 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbYGXAKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:10:24 -0400
Received: by nf-out-0910.google.com with SMTP id d3so997519nfc.21
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3G6silV2P8t7mYPWPk0IGmvOJFnW7pAJl/SYZLTe1rc=;
        b=oUg95zkPZS1H7Igr2xqtQYSckWq0xvmvF/QhQbHeAUdnW7sz5YZxYBpbOeSGLqA674
         xwdDPugFiEDk4RmDkfZKgEI+qA84YPw36Tykqtm3VBC6VzsMnlwAQe0Zog9qiYHQOi9Q
         ljTBy/A6jzkPpCr899AgniS9IeD8ZcBOahnKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kMaIpqsUwHusDPuFGQhw5eEQbUivk+XBg+pvu781qB2MTqtJCJMrxjVKgtAU/uoDFu
         DsdNS+0zEcdOej0Q2y72CuzRAdL7cRJ7SQ5egTj4tHN4L5X7l4o4M7He+LFIQP16VArh
         aoldoB13Qpljkg3D6w2v5Mzkc62r1UyJprfck=
Received: by 10.210.34.5 with SMTP id h5mr479930ebh.84.1216858222777;
        Wed, 23 Jul 2008 17:10:22 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id i4sm17515798nfh.1.2008.07.23.17.10.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 17:10:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwsjcft5g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89817>

On Wed, 23 July 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>> 
>>> Some people prefer to stay anonymous, so I think email is out.
>>> 
>>>>    04. Which programming languages you are proficient with?
>>>>        (The choices include programming languages used by git)
>>>>        (zero or more: multiple choice)
>>>>      - C, shell, Perl, Python, Tcl/Tk
>>>>      + (should we include other languages, like C++, Java, PHP,
>>>>         Ruby,...?)
>>> 
>>> Yes, I think this should be a long list.
>>
>> I'd rather not have a "laundry list" of languages.  I have put C++
>> because QGit uses it, Java because of egit/jgit, PHP for web
>> interfaces, Ruby because of GitHub and because of Ruby comminity
>> choosing Git.  I should perhaps add Emacs Lisp, HTML+CSS and
>> JavaScript here.  What other languages should be considered?
> 
> I refrained saying this in my initial response, but my initial reaction
> was "Why are you even asking this?".
> 
> Yes, "getting to know you" demographics are customary done in surveys, and
> you kept it to the minimum which is also good, but I do not think this
> particular question is very interesting.  For one thing, the question
> assumes the participant is a programmer, and we are giving an impression
> that we are interested in better programmers.  Do we *still* require users
> to be a programmer to use git?  I do not think so.  Having to answer "none
> of these" to this question would make you feel unnecessarily bad, even if
> you are not a programmer and you know at the intellectual level that it is
> not your flaw not to be proficient in any.

The idea, I think, was to gauge which parts of Git would be hard to
find developers for, because of small number of people proficient in
the programming language the part is written in.  I'm thinking here
about Tcl/Tk and gitk and git-gui, see
  http://git.or.cz/gitwiki/GitSurvey2007#head-ecb5564d71e4093e2e93e508380407a26dbcbdea

Nevertheless, _if_ this question is to stay (I am not sure one way or
another), we would better add "I am not programmer" or something like
that to the list of possible answers.

> Asking about geographic location and preferred human languages might help
> to gauge what l10n are desired for GUIs, but even there, don't forget that
> we are no company.  We do not research markets and translate messages to
> missing languages, however popular, before being asked.  That's not how we
> operate.  So the result of these questions will be mainly to satisfy our
> curiosity, nothing more.

It would also answer question if adding support for i18n in git, for
example support for translating git commands messages, is something
which people would want or not.  If they would be translated or not
it would depend on people, but one cannot even begin translation
efforts if there is no infrastructure in place.

But as the rest of localization / internationalization / translation
questions ("What do you need translated?" for example) were removed
from proposed set of questions for this year survey, perhaps this
question should be removed as well.

> "What kind of content do you track" might also be an equally interesting
> question.  It also falls into the curiosity department, though.

True.

What should be the list of possible choices? Source code,
documentation, configuration, backup, binary files, other?

>> I'm not sure about having multiple choice vs. free-form question here.
>> Multiple choice is easier to analyze, especially if one would want
>> histogram of replies...
> 
> And when you expect very many respondents, (1) you cannot afford to
> free-form; and (2) statistics over multiple choices, as long as choices
> are well seeded, will give you a good enough overview picture.

I wonder how many responses will we get this year.  In 2006 there were
around 117 responses (but IIRC it was announced only on git mailing
list, wasn't it?), in 2007 survey there were 683 individual responses.
Git is even more popular now, I think...

OTOH there are some questions, like "feature requests/proposals"
question which *do require* free-form question.  But they should
be few, and preferably for questions for which we don't need
histogram of replies.

I'll convert as much questions as possible to multiple choice
(pre-seeded), trying to come up with a good set of canned responses.


A question: if analysis of responses was not a problem, do you prefer
free form, or "select a choice" question?

>> Again: free form has some hassles, but so does coming up with good
>> choice of fixed answers in multiple choice question.
> 
> You need to do at least one or the other, and I do not think there is any
> way to avoid that.  Without a good choices, histogram would become useless
> (not necessarily because the answer will be dominated by "Other", but the
> seeing the choices tends to set the frame of mind when/before somebody
> answers the question).  With free-form, you will spend the rest of your
> life analyzing to get any useful insight.

True... well, depending of course on the number of replies.  Analysing
around 50 free-form replies (half of 100 individual responses to survey)
is not impossible; analysing 250+ is a lot of work.

-- 
Jakub Narebski
Poland
